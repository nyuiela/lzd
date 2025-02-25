// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Entry} from "./entry.sol";
import {LD} from "../core/LD.sol";

contract CompetitionImplementation {
    IERC20 public usdc;
    LD public xpToken;

    uint256 id;
    address owner;
    Entry entry;

    constructor(address usdcAddr) {
        usdc = IERC20(usdcAddr);
    }

    struct CompetitionParams {
        address creator;
        string name;
        string description;
        uint256[] prize; //
        uint256 score;
        uint256 startTime;
        uint256 stopTime; //duration / deadline
        string category;
        bool claimed;
    }

    struct Submission {
        bytes32 solutionHash;
        bool solved;
    }

    //  mapping(uint256 => bytes32) private solution;
    bytes32 private solution;
    mapping(address => Submission) public submission;

    event CompetitionCreated(
        uint256 indexed competitionId,
        address indexed creator,
        uint256[] prize
    );
    event SubmissionMade(uint256 indexed compId, address participant);
    event WinnersDeclared(
        uint256 indexed compId,
        address[] winner,
        uint256[] prizes
    );

    //function initialize() external{}
    // isActive duration
    // 7th march to 12 march
    // 6th march
    CompetitionParams public competition;
    uint256 competitionId = 0;
    address[] public winners;

    function initialize(uint256 _id, address _owner) public {
        id = _id;
        owner = _owner;
    }

    function createCompetition(
        string memory _name,
        string memory _description,
        uint256[] memory _prize,
        uint256 _score,
        uint256 _startTime,
        uint256 _stopTime,
        string memory _category
    ) external returns (uint256 _competitionId) {
        // msg.sender must meet requirement to create challenge.
        // require()
        //clone the contract
        // send mpney to the contract to lock in for winners ...pize usdc

        competition = CompetitionParams({
            creator: msg.sender,
            name: _name,
            description: _description,
            prize: _prize,
            score: _score,
            //   _isActive, // remove?
            startTime: _startTime,
            stopTime: _stopTime,
            category: _category,
            claimed: false
        });
        competitionId++;

        //how many people wins the competition? 1st? 2nd? 3rd?
        uint256 totalPrize = _prize[0] + _prize[1] + _prize[2];
        usdc.transferFrom(msg.sender, address(this), totalPrize);
        emit CompetitionCreated(competitionId, msg.sender, _prize);
        return competitionId;
    }

    /// _prize usctd ?? xp ??  nft or dollar kinda .... 500 1/2 * 500 = 250  1/2 250 =125 3rd: 250-125 =
    // 3 winners divided =====
    // xp scores

    function submitSolution(bytes32 _solutionHash) external {
        require(competition.creator == msg.sender, "NotOwner");
        //what if we don't have a solution?
        //what if the owner changes the solution??
        solution = _solutionHash;
    }

    function submitFlag(
        uint256 _competitionId,
        bytes32 _solutionHash
    ) external returns (bool) {
        address _user = msg.sender;
        /// xp rewarding right?????
        Submission memory userSub = submission[msg.sender];
        if (solution == userSub.solutionHash) {
            submission[msg.sender] = Submission({
                solutionHash: _solutionHash,
                solved: true
            });
            //claim xp
            entry.addToUserXP(_user, competition.score);

            xpToken.transferFrom(address(this), msg.sender, competition.score);

            //rewardWinner
            return true;
        } else {
            submission[msg.sender] = Submission({
                solutionHash: _solutionHash,
                solved: false
            });
        }
        winners.push(msg.sender);
        emit SubmissionMade(_competitionId, msg.sender);
        return false;
    }

    function rewardCompetition(uint256 _competitionId) external {
        //   CompetitionParams storage competition = competitions[_competitionId];
        require(block.timestamp >= competition.stopTime, "CompetitionNotEnded");
        // require(submission[msg.sender].solved, "CompetitionNotSolved");
        require(competition.claimed == false, "Reward claimed");

        for (uint256 i = 0; i < 2; i++) {
            address winner = winners[i];
            uint256 amount = competition.prize[i];
            usdc.transferFrom(address(this), winner, amount);
        }

        competition.claimed = true;
        emit WinnersDeclared(_competitionId, winners, competition.prize);
    }

    function getId() public view returns (uint256) {
        return id;
    }
}
