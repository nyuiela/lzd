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
    mapping(address => mapping(uint256 => bool)) private _isContributor; 
    uint256 public proposalId;

    event ProposalCreated(uint256 id, address owner, uint256 deadline);
    event ProposalAccepted(uint256 id, address accepter);
    event ApprovalSet(uint256 id, address contributor);
    event Joined(uint256 id, address indexed contributor);

    function createProposal(
        string memory _details,
        string memory _uri,
        address[] memory _contributors,
        uint256 _rewardPool,
        bool _isPrivate,
        uint256 _deadline
    ) external returns (uint256) {
        proposalId++; // Increment proposalId first
        ProposalParam storage proposal = proposals[proposalId];

        proposal.owner = msg.sender;
        proposal.details = _details;
        proposal.uri = _uri;
        proposal.contributors = _contributors;
        proposal.rewardPool = _rewardPool;
        proposal.isPrivate = _isPrivate;
        proposal.deadline = _deadline;

        setApprovals(proposalId, _contributors);
        emit ProposalCreated(proposalId, msg.sender, _deadline);

        return proposalId;
    }

    function setApproval(uint256 _id, address _contributor) public {
        ProposalParam storage proposal = proposals[_id];
        require(proposal.owner == msg.sender, "ProposalContract__Must_Be_owner");

        approved[_id][_contributor] = true;
        _isContributor[_contributor][_id] = true;
        emit ApprovalSet(_id, _contributor);
    }

    function setApprovals(uint256 _id, address[] memory _contributors) public {
        ProposalParam storage proposal = proposals[_id];
        require(proposal.owner == msg.sender, "ProposalContract__Must_Be_owner");

        for (uint256 i = 0; i < _contributors.length; i++) {
            approved[_id][_contributors[i]] = true;
            _isContributor[_contributors[i]][_id] = true;
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

    function getProposal(uint256 _id) external view returns (PartialProposal memory) {
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

        if (!proposal.isPrivate || approved[_id][msg.sender]) {
            return _proposal;
        } else {
            revert("ProposalContract_Must_Be_Approved");
        }
    }

    function getProposalInfo(
        uint256 _id
    ) public view returns (string memory, string memory, bool, uint256, address[] memory, uint256) {
        ProposalParam storage proposal = proposals[_id];
        return (proposal.details, proposal.uri, proposal.isPrivate, proposal.rewardPool, proposal.contributors, proposal.deadline);
    }

    function joinProposal(uint256 _id) external {
        ProposalParam storage proposal = proposals[_id];
        require(!proposal.isPrivate, "ProposalContract__cant_join_privateProposals");
        require(block.timestamp <= proposal.deadline, "ProposalContract_Deadline_Passed");

        approved[_id][msg.sender] = true;
        _isContributor[msg.sender][_id] = true;

        emit Joined(_id, msg.sender);
    }

    function acceptProposal(uint256 _id) public {
        ProposalParam storage proposal = proposals[_id];
        require(!proposal.accepted[msg.sender], "Already accepted");
        require(block.timestamp <= proposal.deadline, "ProposalContract_Deadline_Passed");

        for (uint256 i = 0; i < proposal.contributors.length; i++) {
            if (proposal.contributors[i] == msg.sender) {
                proposal.accepted[msg.sender] = true;
                _isContributor[msg.sender][_id] = true;
                emit ProposalAccepted(_id, msg.sender);
                return;
            }
        }

        revert("ProposalContract_Not_A_Contributor");
    }

    function isContributor(uint256 _id) public view returns (bool) {
        return _isContributor[msg.sender][_id];
    }
}
