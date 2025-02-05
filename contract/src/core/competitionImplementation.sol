// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;


contract CompetitionImplementation {

   
   struct Competition {
        uint256 templateId; // Links to the base competition
        address creator;
        string name;
        string description;
        uint256 prize;
        bool isActive;
        uint256 duration;
        address winner;
   }

   struct Submission {
      address participant;
      string solutionHash;
   }

    struct Template {
      string name;
      string description;
    }

    Template[] public templates;
    mapping(uint256 => Competition[]) public competitionsByTemplate;
    mapping(uint256 => Submission[]) public submissions;
    
    event TemplateCreated(uint256 templateId, string name);
    event CompetitionCreated(uint256 indexed templateId, uint256 indexed compId, address creator, uint256 prize);
    event SubmissionMade(uint256 indexed compId, address participant);
    event WinnerDeclared(uint256 indexed compId, address winner);

   // function createCompetition()
   // function rewardCompetition()
   // function submitSolution()
   // function declareWinner()
   
}