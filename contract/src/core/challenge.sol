// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {LD} from "../core/LD.sol";
import {Entry} from "./entry.sol";

contract ChallengeImplementation {
    LD public xpToken;
    uint256 public id;
    address owner;
    Entry entry;

    constructor(address xpTokenAddr) {
        xpToken = LD(xpTokenAddr);
    }

    struct Submission {
        bytes32 solutionHash;
        bool solved;
    }
    mapping(address => Submission) public submission;

    struct ChallengeParams {
        ///  uint256 challengeId; // Links to the base competition
        address creator;
        string name;
        string description;
        uint256 score; //xp going to be added
        string category;
    }

    ChallengeParams public challenge;

    uint256 challengeId = 0;
    bytes32 private solution;

    //  Submission[] private submission;

    function initialize(uint256 _id, address _owner) public {
        id = _id;
        owner = _owner;
    }

    function createChallenge(
        string memory _name,
        string memory _description,
        uint256 _score,
        string memory _category
    ) external returns (uint256) {
        // msg.sender must meet requirement to create challenge.

        challenge = ChallengeParams({
            creator: msg.sender,
            name: _name,
            description: _description,
            score: _score,
            category: _category
        });
        challengeId++;
        return challengeId;
    }

    function submitSolution(bytes32 _solutionHash) external {
        ChallengeParams memory _challenge = challenge;
        require(_challenge.creator == msg.sender, "NotOwner");

        solution = _solutionHash;
    }

    function submitChallengeFlag(
        /*uint256 _challengeId,*/
        bytes32 _solutionHash
    ) external returns (bool) {
        //  address challenge = factory.lookUpChallenge(_challengeId);
        // this gives the cloned challenge address
        // what can we do with the challenge address? help bro?
        // we need to talk, this needs a brainstorming session. lol
        address _user = msg.sender;
        Submission storage userSub = submission[msg.sender];
        require(userSub.solved == false, "challenge Already solved");
        if (_solutionHash == submission[msg.sender].solutionHash) {
            submission[msg.sender] = Submission({
                solutionHash: _solutionHash,
                solved: true
            });

            // xp[msg.sender] += _challenge.score;
            //rewardWinner
            entry.addToUserXP(_user, challenge.score);

            xpToken.transferFrom(address(this), msg.sender, challenge.score);
            return true;
        } else {
            submission[msg.sender] = Submission({
                solutionHash: _solutionHash,
                solved: false
            });
        }

        return false;
    }

    function getChallengeDetails()
        public
        view
        returns (ChallengeParams memory)
    {
        return challenge;
    }
}
