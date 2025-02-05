//SPDX-Lisence-Identifier:MIT
Pragma solidity 0.8.28;

library DataTypes{

struct Userparam{
    address user;
    uint256 xp;
    string username;
}

enum Level {
   LEVEL001, //10000
   LEVEL002, //100
   LEVEL003 //10
}

// each game for a user -> address -> levelInfo (gameId);
struct UserLevelInfo{
     Userparam user; 
    Level level;
    bytes32 id; //  CompetitionParams competition;
    bool hasCompletedLevel;
}

// mappping( address -> uint256) public xp;

struct CompetitionParams {
   bytes32 id;
   address[] participants;
   uint256[] score;
   
   // participant[i] = score[i];
   // mapping(address => uint256) score;
}
// mapping(Userparam => CompetitionParams) public scoreBOard

enum WinningType {
   NFT,
   TOKENS,
   NFTANDTOKENS
}

struct Winning{
   bytes32 id; // competition id
   address[] user;
   uint256[] place;
   uint256[] won; // amount / what you won
   WinningType winningType;
}



}