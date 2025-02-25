// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./challenge.sol";
import "./competition.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CreationFactory is Ownable {
    using Clones for address;

    address[] public challenges;
    address[] public competitions;

    address public competition;
    address public challenge;

    constructor(address _competition, address _challenge) Ownable(msg.sender) {
        competition = _competition;
        challenge = _challenge;
    }

    function cloneCompetition(
        address _owner
    ) external onlyOwner returns (address, uint256) {
        address newCompetition = competition.clone();
        uint256 _id = competitions.length;
        // add owner;
        CompetitionImplementation(newCompetition).initialize(_id, _owner); // add msg.sender;
        competitions.push(newCompetition);
        //   newCompetition();
        return (newCompetition, _id);
    }

    function cloneChallenge(
        address _owner
    ) external onlyOwner returns (address, uint256) {
        address newChallenge = challenge.clone();
        uint256 _id = challenges.length;
        ChallengeImplementation(newChallenge).initialize(_id, _owner);
        competitions.push(newChallenge);
        return (newChallenge, _id);
    }

    function lookUpCompetition(uint256 _id) public view returns (address comp) {
        comp = competitions[_id];
    }

    function lookUpChallenge(uint256 _id) public view returns (address chal) {
        chal = challenges[_id];
    }

    // function getChallengeDetails()
    //   public
    // view
    //returns (challenge.ChallegeParams memory)
    // {
    //challenge.ChallengeParams memory _challenge = challenge.getChallengeDetails();
    // }
    // function InitialiseCompetition() internal {}

    // strcture the competition question for
    // i want to a smart contrat that sets up competions for devs , like puzzels and ctfs and yk , but anyone can creat this comeption , how do i build this,
}
