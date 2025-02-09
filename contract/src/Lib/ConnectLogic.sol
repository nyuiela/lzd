// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import "../interface/IChallengeImpl.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
contract ConnectLogic {
    //bool solved ;
    address public startConnectAddress;
    IChallengeImplementation startChallenge;
    uint256 duration = 3 days;

    struct Userparam {
        address user;
        uint256 xp;
        string username;
    }

    mapping(string => bool) usernameExists;
    mapping(address => Userparam) public profile;
    mapping(address => bool) public solvedConnectChallenge;

    mapping(address => uint256) public startChaDeadline;

    constructor() {
        startChallenge = IChallengeImplementation(startConnectAddress);
    }

    function _connect(string memory _username) internal {
        require(
            usernameExists[_username] == false,
            "Connect__Username_Isnt_Avaliable"
        );
        profile[msg.sender] = Userparam({
            user: msg.sender,
            xp: 0,
            username: _username
        });
        usernameExists[_username] = true;
    }

    function getProfile(
        address _user
    ) external view returns (Userparam memory) {
        return profile[_user];
    }

    //    address creator;
    //   string name;
    //   string description;
    //   uint256 score; //xp going to be added
    //   string category;
    function startConnectChallenge()
        internal
        returns (address, string memory, string memory, uint256, string memory)
    {
        //   start the game, connect user to the challenge.
        //  xp[msg.sender] += 300;
        require(
            startChaDeadline[msg.sender] != 0 &&
                block.timestamp >= startChaDeadline[msg.sender],
            "Hello world"
        );
        startChaDeadline[msg.sender] = block.timestamp + duration;
        return startChallenge.challenge();
    }

    function setConnectChallenge(address gameAddress) external /* onlyOwner */ {
        startConnectAddress = gameAddress;
    }

    //  function setStartChallange() public {
    //    factory.cloneChallenge();
    //  }

    // function startCOnnectChallenge() internal {} // will be at the start, worth xp , but you can skip and do it later
    //checks if user is hasPlayed;

    // connect github -> access_token -> pullgithubDetails -> fillUserprofile. -> assign user xp;
    // function createProfile() internal{}
    // bool solved = startConnectChallenge();

    //}
}
