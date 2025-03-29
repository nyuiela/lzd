// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Proposal {
    struct ProposalParam {
        address owner;
        string details;
        string uri;
        address[] contributors;
        uint256 rewardPool;
        mapping(address => bool) accepted;
        bool isPrivate;
        uint256 deadline;
    }

    mapping(uint256 => ProposalParam) private proposals;
    mapping(uint256 => mapping(address => bool)) private approved;
    uint256 public proposalId;

    mapping(address => uint256 => bool) private _isContributor;

    event ProposalCreated(uint256 id, address owner, uint256 deadline);
    event ProposalAccepted(uint256 id, address accepter);
    event ApprovalSet(uint256 id, address contributor);

    function createProposal(
        string memory _details,
        string memory _uri,
        address[] memory _contributors,
        uint256 _rewardPool,
        bool _isPrivate,
        uint256 _deadline
    ) external returns (uint256 _proposald) {
        ProposalParam storage proposal = proposals[_proposald];
        proposal.owner = msg.sender;
        proposal.details = _details;
        proposal.uri = _uri;
        proposal.contributors = _contributors;
        proposal.rewardPool = _rewardPool;
        //   proposal.accepted = ;
        proposal.isPrivate = _isPrivate;
        proposal.deadline = _deadline;

        setApprovals(proposalId, _contributors);
        emit ProposalCreated(proposalId, msg.sender, _deadline);
        proposalId++;
        return proposalId;
    }

    function setApproval(uint256 _id, address _contributor) public {
        ProposalParam storage proposal = proposals[_id];
        require(
            proposal.owner == msg.sender,
            "ProposalContract__Must_Be_owner"
        );
        //   require(_contributor); // check that this persons address s regissted on the lazydev platform
        //check if address has minXP to join

        approved[_id][_contributor] = true;
        _isContributor[_contributor][_id] = true;
        emit ApprovalSet(_id, _contributor);
    }

    function setApprovals(uint256 _id, address[] memory _contributors) public {
        ProposalParam storage proposal = proposals[_id];
        require(
            proposal.owner == msg.sender,
            "ProposalContract__Must_Be_owner"
        );
        for (uint256 i = 0; i < _contributors.length; i++) {
            approved[_id][_contributors[i]] = true;
             _isContributor[_contributor][_id] = true;
        }
    }

    struct PartialProposal {
        address owner;
        string details;
        string uri;
        address[] contributors;
        uint256 rewardPool;
        bool isPrivate;
        uint256 deadline;
    }

    function getProposal(
        uint256 _id
    ) external view returns (PartialProposal memory) {
        ProposalParam storage proposal = proposals[_id];
        PartialProposal memory _proposal = PartialProposal({
            owner: proposal.owner,
            details: proposal.details,
            uri: proposal.uri,
            contributors: proposal.contributors,
            isPrivate: proposal.isPrivate,
            rewardPool: proposal.rewardPool,
            deadline: proposal.deadline
        });
        if (!proposal.isPrivate) {
            return _proposal;
        } else {
            require(approved[_id][msg.sender], "ProposalContract_Must_Be_Ap");
            return _proposal;
        }
    }

function getProposalInfo(uint256 _id) public view returns(ProposalParam memory){
     ProposalParam storage proposal = proposals[_id];
     return(Proposal.details, proposal.uri, proposal.isPrivate, proposal.rewardPool,proposal.contributors, proposal.deadline);
}
    function joinProposal(uint256 _id) external {
         ProposalParam storage proposal = proposals[_id];
         require(!proposal.isPrivate, "ProposalContract__cant_join_privateProposals");
          require(
            block.timestamp <= proposal.deadline,
            "ProposalContract_Deadline_Passed"
        );
        approved[_id][_contributor] = true;
         _isContributor[_contributor][_id] = true;
        emit Joined(_id, _contributor);
    }
    event Joined(uint256 id, address indexed con);

    function acceptProposal(uint256 _id) public {
        ProposalParam storage proposal = proposals[_id];
        require(!proposal.accepted[msg.sender], "Already accepted");
        require(
            block.timestamp <= proposal.deadline,
            "ProposalContract_Deadline_Passed"
        );

        for (uint256 i; i < proposal.contributors.length; i++) {
            if (proposal.contributors[i] == msg.sender) {
                proposal.accepted[msg.sender] = true;
                 _isContributor[msg.sender][_id] = true;
            }
        }
    }
    function isContributor(uint256 _id) public view returns(bool){
         ProposalParam storage proposal = proposals[_id];
         // _isContributor[msg.sender][_id] = true;
          return _isContributor[msg.sender][_id];

    }


    //  function addContributor(uint256 _id, uint256 _contributor) external {
    //      ProposalParam storage proposal = proposals[_id];

    //  }
}
