// SPDX-License-Identifier: MIT 
pragma solidity 0.8.28;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
contract ConnectLogic {
//bool solved ;

struct Userparam{
    address user;
    uint256 xp;
    string username;
}

mapping(string => bool) usernameExists;
 mapping(address => Userparam) public profile;
 mapping(address => bool) public solvedConnectChallenge;

 function _connect(string _username) external {
   require(usernameExists[ _username] == false, "Connect__Username_Isnt_Avaliable");
   profile[msg.sender] = Userparam({
      msg.sender,
      0,
      _username
   });
   usernameExists[_username] = true;
 }

 function getProfile(address _user) external returns (Userparam memory) {
   return profile[msg.sender];
 }

 
   // function startCOnnectChallenge() internal {} // will be at the start, worth xp , but you can skip and do it later
   //checks if user is hasPlayed;


   // connect github -> access_token -> pullgithubDetails -> fillUserprofile. -> assign user xp;
   // function createProfile() internal{}
   // bool solved = startConnectChallenge();

   //}

 


}