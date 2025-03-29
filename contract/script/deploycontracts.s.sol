// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import"../src/core/challenge.sol";
import "../src/core/competition.sol";
import  "../src/core/contribution.sol";
import  "../src/core/CreationFactory.sol";
import "../src/core/Dao.sol";
import "../src/core/entry.sol";
import "../src/core/LD.sol";
import "../src/core/proposalContract.sol";

contract DeployScript is Script {
   ChallengeImplementation  challenge;
   CompetitionImplementation competition;
    Contribution  contribution;
     CreationFactory  factory;
 Dao  dao;
 Entry entry;
  LD  ld;
  Proposal proposal;
  address owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
  address lzEndpoint;
  IERC20 public usdc;

    function run() public {
        
      //  vm.createSelectFork("localchain");
        vm.createSelectFork(vm.rpcUrl("anvil"));

        vm.startBroadcast();
          proposal = new Proposal();
           ld = new LD("LD", "LD", address(lzEndpoint), address(owner), 10000000000000000000000000000000000000);
        challenge = new ChallengeImplementation(address( ld ));
        competition = new CompetitionImplementation(address(usdc));
        contribution = new Contribution(address(proposal));
        entry = new Entry(address(ld),address(owner), address(challenge), address(competition), 1000000000000000000000000000000000000000000000000);
        factory = new CreationFactory(address(competition), address(challenge));
      
        dao = new Dao(uint256(100), address(entry), address(ld));
        
        vm.stopBroadcast();
        console.log("NEXT_PUBLIC_ENTRY_ADDRESS=", address(entry));
        console.log("NEXT_PUBLIC_FACTORY_ADDRESS=", address(factory));
        console.log("NEXT_PUBLIC_PROPOSAL_ADDRESS=", address(proposal));
        console.log("NEXT_PUBLIC_LD_ADDRESS=", address(ld));
          console.log("NEXT_PUBLIC_DAO_ADDRESS=", address(dao));
            console.log("NEXT_PUBLIC_CONTRIBUTION_ADDRESS=", address(contribution));
    }
}