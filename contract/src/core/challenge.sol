// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;
import "@openzeppelin-contracts/token/ERC20/IERC20.sol";

contract Challenge {
    IERC20 public xpToken;

   constructor(address xpTokenAddr) {
    xpToken = IERC20(xpTokenAddr);
   }

   

    struct Submission {   
      string solutionHash;
      bool solved;
   }

struct ChallengeParams {
      ///  uint256 challengeId; // Links to the base competition
        address creator;
        string name;
        string description; 
        uint256 score; //xp going to be added 
        string category;
   }
   
ChallengeParams[] public challenge;

 uint256 challengeId = 0;
 bytes32 private solution;
//  Submission[] private submission;
 mapping(address => Submision) public submission;

  
   function createChallenge(string memory _name, string memory _description, uint256 _score, string memory _category) external returns(uint256 challengeId) {
      // msg.sender must meet requirement to create challenge.
      // require()
      //clone the contract
      ChallengeParams storage Challenge = ChallengeParams({
        msg.sender,
        _name,
        _description,
        _score,
        _category
      });
      challengeId++;
      return challengeId;
}
   
   function submitSolution(uint256 _challengeId, bytes32 _solutionHash) external {
      ChallengeParams memory challenge = ChallengeParams[_challengeId];
      require(challenge.creator == msg.sender, "NotOwner");

      solution = _solutionHash;
      
   }

   function submitFlag(uint256 _challengeId, bytes32 _solutionHash) external returns(bool){
    ChallengeParams memory challenge = ChallengeParams[_challengeId];

    if (solution.solutionHash == submission.solutionHash) {
      submission[msg.sender] = Submission({
        _solutionHash,
        true
      });

      //rewardWinner
      return true;
    } else () {
      submission[msg.sender] = Submission({
        _solutionHash,
        false
      });
    }

    return false;
   }
   


}