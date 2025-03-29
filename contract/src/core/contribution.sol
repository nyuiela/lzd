// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./proposalContract.sol";

contract Contribution {
    uint256 private ciD;
    Proposal private proposal;

    struct ContributorPara {
        string uri;
        string feedback;
        uint256 proposalId;
        uint256 contributionC;
        uint256 validCounts;
        uint256 inValidCounts;
    }

    struct ValidatorParam {
        string feedback;
        bool isValid;
        uint256 time;
        bool isActiveValidator;
        uint256 reward;
        uint256 penalty;
        uint256 numberOfContributorsValidated;
        uint256 proposalId;
        uint256 contributorId;
    }

    mapping(uint256 => ContributorPara) public contributionInfo;
    mapping(address => ValidatorParam) public validationInfo;
    address[] public validators;
    mapping(address => mapping(uint256 => bool)) public validatorToContributor;

    bool public activeValidation;

    event ContributionMade(uint256 indexed ciD, address contributor, uint256 proposalId);
    event ValidatorAdded(address validator);
    event ContributionValidated(uint256 indexed ciD, address validator, bool isValid);

    /// @notice Ensures only registered validators can call a function
    modifier onlyValidator() {
        require(isValidator(msg.sender), "Must be a validator");
        _;
    }

    /// @notice Checks if an address is a validator
    function isValidator(address _addr) public view returns (bool) {
        for (uint256 i = 0; i < validators.length; i++) {
            if (validators[i] == _addr) {
                return true;
            }
        }
        return false;
    }

    /// @notice Allows contributors to submit a contribution
    function contribute(uint256 _id, string memory _uri, string memory _feedback) external returns (uint256) {
        // Ensure the proposal is active
        proposal.getProposalInfo(_id);
        require(proposal.isContributor(_id), "Only contributors can contribute");

        uint256 newCID = ciD++;

        contributionInfo[newCID] = ContributorPara({
            uri: _uri,
            feedback: _feedback,
            proposalId: _id,
            contributionC: 1, // First contribution
            validCounts: 0,
            inValidCounts: 0
        });

        emit ContributionMade(newCID, msg.sender, _id);
        return newCID;
    }

    /// @notice Allows an admin to add a validator
    function addValidator(address _validator) external {
        require(_validator != address(0), "Invalid validator address");
        require(!isValidator(_validator), "Already a validator");

        validators.push(_validator);
        emit ValidatorAdded(_validator);
    }

    /// @notice Allows validators to validate contributions
    function validate(uint256 _ciD, string memory _feedback, bool _isValid) external onlyValidator {
        require(contributionInfo[_ciD].proposalId != 0, "Contribution does not exist");
        require(!validatorToContributor[msg.sender][_ciD], "Already validated this contribution");

        validatorToContributor[msg.sender][_ciD] = true;

        validationInfo[msg.sender] = ValidatorParam({
            feedback: _feedback,
            isValid: _isValid,
            time: block.timestamp,
            isActiveValidator: true,
            reward: 0,
            penalty: 0,
            numberOfContributorsValidated: validationInfo[msg.sender].numberOfContributorsValidated + 1,
            proposalId: contributionInfo[_ciD].proposalId,
            contributorId: _ciD
        });

        if (_isValid) {
            contributionInfo[_ciD].validCounts += 1;
        } else {
            contributionInfo[_ciD].inValidCounts += 1;
        }

        emit ContributionValidated(_ciD, msg.sender, _isValid);
    }

    /// @notice Retrieves contributor information
    function getContributorsInfo(uint256 _ciD) public view returns (ContributorPara memory) {
        return contributionInfo[_ciD];
    }
}
