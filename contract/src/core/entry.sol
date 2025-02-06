// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import "./Data_Structure/dataTypes.sol";
import "@openzeppelin-contracts/token/ERC20/IERC20.sol";

interface NFTManager {
   function addNFT() external;
   function removeNFT() external;
}
contract Entry {
      IERC20 public xpToken;
      NFTManager public nftManager;

      // ERC721MANAGER - manages all the erc721 tokens for our platform.
      constructor (addresss xpTokenAddr,address NFTManagerAddr) {
         xpToken = IERC20(xpTokenAddr);
         nftManager = NFTManager(NFTManagerAddr);
      }

    mapping(address => uint256) public xp;

    function connect() /* ??onlyOwner() */ { //ConnectLogic::createProfile
      // add / create profile for user.
      // xp[msg.sender/addr] = 1;
    }
 
    function createCompetition() /*onlyOwner? */ {} // fcfm, cfm // fcfm --- cfm -- clone (not expensive)
    function claimXp() {
      // param: selctor
      // function handle().selector 
      // cliamLogic.changexp.selctor
      // uint256 amount = 
      xp[msg.sender] += amount;
    }

    function createProposal() {} // company / individual must meet requirement.
    // requirement: min xp requirement or approved Company

   function _claimXp(uint256 amount) internal {
     xp[msg.sender] += amount;
    }
}