// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "../Data_Structures/dataTypes.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CreationFactory.sol";

interface NFTManager {
    function addNFT() external;

    function removeNFT() external;
}

contract Entry {
    IERC20 public xpToken;
    NFTManager public nftManager;
    CreationFactory factory;

    // ERC721MANAGER - manages all the erc721 tokens for our platform.
    constructor(
        address xpTokenAddr,
        address NFTManagerAddr,
        address _challenge,
        address _competition
    ) {
        xpToken = IERC20(xpTokenAddr);
        nftManager = NFTManager(NFTManagerAddr);
        factory = new CreationFactory(_competition, _challenge);
    }

    mapping(address => uint256) public xp;
    uint256 minCreationBalance;

    function connect() public /* ??onlyOwner() */ {
        //ConnectLogic::createProfile
        // add / create profile for user.
        // xp[msg.sender/addr] = 1;
    }

    function createCompetition() public /*onlyOwner? */ {
        uint256 userbalance = xpToken.balanceOf(msg.sender);
        require(
            userbalance >= minCreationBalance,
            "User does not have enough xp"
        );

        factory.cloneCompetition(msg.sender);
    } // fcfm, cfm // fcfm --- cfm -- clone (not expensive)

    function createChallenge() public {
        uint256 userbalance = xpToken.balanceOf(msg.sender);
        require(
            userbalance >= minCreationBalance,
            "User does not have enough xp"
        );

        factory.cloneChallenge(msg.sender);
    }

    function claimXp() public {
        // param: selctor
        // function handle().selector
        // cliamLogic.changexp.selctor
        // uint256 amount =
        xp[msg.sender] += 300; //amount
    }

    // automate this function to get userXp from automateXp, projectXp etc etc.

    function createProposal() public {} // company / individual must meet requirement.

    // requirement: min xp requirement or approved Company

    function _claimXp(uint256 amount) internal {
        xp[msg.sender] += amount;
    }
}
