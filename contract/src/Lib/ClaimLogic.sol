// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract ClaimLogic {
    modifier onlyAutomater() {
        // only the automater can access
        _;
    }

    function automatedXp() external onlyAutomater {}

    // logic for claiming , all internal function needed

    // function automatedXp() internal{} onlyAutomater //pull, push request,

    // function competitionXp() internal{} //

    // function challengeXp() internal {}

    function contributionXp() internal {} // check workflow --workflow rewardbased

    function projectSpecificXp() internal {} // company / individual wants contribution and pay with with your own xp/erc20/nft

    // function creationXp internal {} // xp increase, nft
}

/// reason in for clone
// so each competion / chanllenge can be deployed
// lets say like ctf smart -- deployed -- contract dee

// com/ca
// address of the challenge ????
