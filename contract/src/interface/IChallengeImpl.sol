// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

interface IChallengeImplementation {
    // State Variables
    function xpToken() external view returns (address);

    function id() external view returns (uint256);

    function owner() external view returns (address);

    function challenge()
        external
        view
        returns (
            address creator,
            string memory name,
            string memory description,
            uint256 score,
            string memory category
        );

    function submission(
        address user
    ) external view returns (bytes32 solutionHash, bool solved);

    // Functions
    function initialize(uint256 _id, address _owner) external;

    function createChallenge(
        string memory _name,
        string memory _description,
        uint256 _score,
        string memory _category
    ) external returns (uint256);

    function submitSolution(bytes32 _solutionHash) external;

    function submitFlag(bytes32 _solutionHash) external returns (bool);
}
