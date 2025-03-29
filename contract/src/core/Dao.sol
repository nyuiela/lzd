// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Entry} from "./entry.sol";
import "./LD.sol";

contract Dao is ERC20 {
    IERC20 LDGov;
    LD public xpToken;
    Entry entry;
    uint256 public constant PRECISION = 1e8;
    uint256 public constant MAX_NEEDED_TO_EXECUTE = 50;
    uint256 userPower;

    mapping(address => userMintInfo) public userToPowerInfo;

    constructor(uint256 _duration, address _entry, address _xpToken) ERC20("LDGov", "LDG") {
        votingDuration = _duration;
        entry = Entry(_entry);
        xpToken = LD(_xpToken);
    }

    struct userMintInfo {
        uint256 power;
        uint256 availablePower;
        bool hasBoughtBefore;
    }

    // mapping(address => userMintInfo) public user; // 50 // 20
    function mintToken(address to, uint256 _amount) external {
        //userMintInfo
        uint256 _power;
        uint256 amountTomint;
        // check user LDGov balance /// check if the used this function

        if (!userToPowerInfo[msg.sender].hasBoughtBefore) {
            (_power) = calculateUserLDT();
            require(_power >= _amount, "Dao__NotEnoughBalance");
            userToPowerInfo[msg.sender] = userMintInfo({
                power: _amount,
                availablePower: _amount,
                hasBoughtBefore: true
            });
        } else {
            (_power) = calculateUserLDT();
            uint256 newPower = _power - userToPowerInfo[msg.sender].power;
            require(newPower >= _amount, "Dao__NotEnoughBalance");
        }
        //  amountTomint = (totalSupply() * PRECISION) / _amount;
        // userPower = _power ;
        amountTomint = (totalSupply() * PRECISION) / _amount;
        userToPowerInfo[msg.sender].power += amountTomint;

        _mint(to, amountTomint);
    }

    //   bool hasVoted;

    struct Proposal {
        uint256 id;
        string description;
        uint voteCount;
        uint256 deadline;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public votes;
    uint256 public proposalCount;
    uint256 public votingDuration;

    event ProposalCreated(uint256 count, string desc, uint256 deadline);
    event ProposalExecuted(uint256 id, uint256 voteCount);

    function vote(uint256 _id, uint256 _power) public {
        Proposal storage proposal = proposals[_id];
        require(
            block.timestamp < proposals[_id].deadline,
            "Dao__proposalPeriod_Over"
        );
        require(!votes[_id][msg.sender], "Already voted");

        votes[_id][msg.sender] = true;
        proposal.voteCount++;
        require(_power >= 1);
        userToPowerInfo[msg.sender].availablePower -= _power;
        LDGov.transferFrom(msg.sender, address(this), _power);
    }

    function makeProposal(string memory _description) public returns (uint256) {
        proposalCount++;
        proposals[proposalCount] = Proposal(
            proposalCount,
            _description,
            0,
            block.timestamp + votingDuration,
            false
        );

        emit ProposalCreated(
            proposalCount,
            _description,
            proposals[proposalCount].deadline
        );
        return proposalCount;
    }

    function executeProposal(uint256 _id) public /*onlyOwner*/ {
        Proposal storage proposal = proposals[_id];
        require(
            block.timestamp > proposal.deadline,
            "Voting period has not ended"
        );
        require(!proposal.executed, "Proposal already executed");
        require(proposal.voteCount < MAX_NEEDED_TO_EXECUTE);
        proposal.executed = true;

        emit ProposalExecuted(_id, proposal.voteCount);
    }

    function calculateUserLDT() public view returns (uint256 amount) {
        amount = entry.getuserAmount();
    }

    function hasVoted(uint256 _id) public view returns (bool) {
        return votes[_id][msg.sender];
    }
}
