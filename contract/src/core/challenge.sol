// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract Challenge {
      
   struct Challenge {
        uint256 templateId; // Links to the base competition
        address creator;
        string name;
        string description;
        uint256 score; //xp going to be added 
   }

    struct Submission {
      address participant;
      string solutionHash;
   }

    struct Template {
      string name;
      string description;
    }

    
   // function createChallenge()
   
   // function submitSolution()


}