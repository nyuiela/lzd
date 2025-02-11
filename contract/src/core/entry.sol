// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "../Data_Structures/dataTypes.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CreationFactory.sol";
import "../Lib/ConnectLogic.sol";
import "../Lib/ClaimLogic.sol";

interface NFTManager {
    function addNFT() external;

    function removeNFT() external;
}

contract Entry is ConnectLogic {
    IERC20 public xpToken;
    NFTManager public nftManager;
    CreationFactory factory;
    ClaimLogic claim;

    //  uint256 public connectReward;

    // ERC721MANAGER - manages all the erc721 tokens for our platform.
    constructor(
        address xpTokenAddr,
        address NFTManagerAddr,
        address _challenge,
        address _competition,
        uint256 _minCreationXp
    ) {
        xpToken = IERC20(xpTokenAddr);
        nftManager = NFTManager(NFTManagerAddr);
        factory = new CreationFactory(_competition, _challenge);
        minCreationXp = _minCreationXp;
    }

    mapping(address => uint256) public xp;
    uint256 public minCreationXp;

    function connect(string memory _username, bool _playEntryChallenge) public {
        //  Userparam memory userInfo = profile[msg.sender];
        // require(userInfo.user == address(0), "Entry__This_user_is_registered");
        // check if has connected before then revert iif true

        require(
            getProfile(msg.sender).user == address(0),
            "Entry__This_user_is_registered"
        );

        _connect(_username);
        //  console.log("DO you want to play a challenge for Xp? ");
        if (_playEntryChallenge) {
            startConnectChallenge();
        }
        xp[msg.sender] += 10;

        //ConnectLogic::createProfile
        // add / create profile for user.
        // xp[msg.sender/addr] = 1;
    }

    //  function setReward(uint256 _reward) external /* onlyOwner */ {
    //    connectReward = connectR
    //  }

    function createCompetition() public /*onlyOwner? */ {
        uint256 userbalance = xpToken.balanceOf(msg.sender);
        require(userbalance >= minCreationXp, "User does not have enough xp");

        factory.cloneCompetition(msg.sender);
    } // fcfm, cfm // fcfm --- cfm -- clone (not expensive)

    function setMinCreationXp(uint256 _value) external /* onlyOwner */ {
        minCreationXp = _value;
    }

    function createChallenge() public {
        uint256 userbalance = xpToken.balanceOf(msg.sender);
        require(userbalance >= minCreationXp, "User does not have enough xp");

        factory.cloneChallenge(msg.sender);
    }

    function claimXp(bytes calldata _selector, uint256 _value) public {
        // if(_selector == claim.chanllenge.selctor){}
        //if()
        //  = claim._competition.selector();
        (bool success, ) = address(claim).call(_selector);
        require(success, "ClaimLogic__Claim_failed");
        //   revert 0;

        // param: selctor
        // function handle().selector
        // cliamLogic.changexp.selctor
        // uint256 amount =
        xp[msg.sender] += _value; //amount
    }

    // automate this function to get userXp from automateXp, projectXp etc etc.

    //  function createProposal() public {} // company / individual must meet requirement.

    // requirement: min xp requirement or approved Company

    function _claimXp(uint256 amount) internal {
        xp[msg.sender] += amount;
    }
}
