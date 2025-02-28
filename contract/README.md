### LazyDev

Got it! You want a template-based competition system where users can initialize a base competition, and others can "clone" it to create their own version.

How It Works
Admin or anyone initializes a base competition template.
Users can "clone" the competition and create their own instance.
Each cloned competition has its own prize, owner, and submissions.

**Core**

- erc721, erc20 contract
- reward
- nft badges - erc721
- open source private - erc1155 ( minted for a specific token - can hold value to be redeemed) // payable ?
- competitions
- reputation
- entryContract

**Data_STuct**

- datastructure(struct & enum)
- error contract

**LOgic**

- rewardLogic contract
- reputationLogic
- entrycontractLogic
- workFlowLogic

// reserve something? okay

// like if the user as like 5 badges +
// random -- very nft
/// 3 final
// 2.5 8 5

// Docs

// entry contract has a challenge ... hack the contarct ... move, rust, solidity, vyper, ton
// unique nft minting at specific level (nfts are limited)
// workflow ?? check quality code?

// commmunity , interact with each other , discusion
That sounds like an awesome idea! You'll need a smart contract that allows users to:

////
Create competitions – Users should be able to create a competition with details like the name, description, prize, difficulty, and deadline.
Submit solutions – Participants can submit solutions (could be a hash, a file, or a link to their solution).
Validate winners – The creator should be able to verify and mark winners.
Distribute rewards – Prize money (in crypto) should be automatically sent to the winner(s).
Allow public competition creation – Any user should be able to create a competition.

/////

### thinking

- we should have like a place where devs can see all the open-source projects and the rewards for participating in them
- can even be a play where new devs can learn soldity, rust,vyper etc through the competitions and get xp .... all ctfs in web3 and let them play and they can increase xp with that.
- Build Your Skill UP ( Game it UP)

-- create proposal
-- generate id for each github project open for collaboration;

-- competition -- anyone can create competition, time based , earns nft and xp earns
-- challenge -- anyone can create , not timebased..can be there forver, earns xp

### research

- how is the competition logic going to ?
- game implementation ( dealing with hwo the user will play the game) is it code based ? will he run codes?
- how to store the game logic? bytes32? if so.

###

## user connect

How the user will connect his github (CI/CD) to the project;
access token -> api.github.com ( gets the user pull, push request) -> imports data or commit proof into contract
this allows the contributionXp, automatedXp, projectSpecificXp to proof or automate user contribution and mints xptokens.
uses oracle to fetch (api.github.com) data into smart contract.

## TOdo

- CREATING PROFILE
- Create proposal

## what I am forgetting

users to prove their income or creditworthiness without revealing their full financial history

### what we havent done

## ZKTLS

## contribution workflow

## teamwork

### LAzyDEv

- dashboard contract(dashboard to want devs based on xp and nft and prize wins)
- DAO contract (contract for devs to vote for changes and make the protocol better)
- /proof of work contract (contract to reward contribution and PR based on quality/workflow)
- TOken contract
- NFT contract
- challenge contract(time-less challenge devs can play , anyone can create these, rwards in xp for solving)
- competition contract(contract to allow devs with a leve of xp to create time-based competions with usdc rewards prizes to 1st to 3rd winners)
- proposal contract (where open source agencies can request for contributors)
- reward contract (rewards devs with xp and nft based on chanllenge,competition and contribution/PR)
- Collaborative Milestone Rewards contract(rewards based on team contribution)

-----LAZYDEV-----

- a dao
- layerzero

method
competition/challennge -> submitFlag() -> entry.addToUserXP(30) onlyChallenge/onlyCompetition;

### Todo

## Kaleel part (meanieeeeeeeee)

-- ZKTLS -- connect()
verifying user -> userprofile -> validate userprofile (token(jwk -- random value)) ->

## Lee part -------------------------------------------------------------------------------

-- workflow ----- connect --- github --- contr --- workflow --- zk --- award(proposal)
contribution H, M, L, I
github...
workflow to know which cat youre on?
-- a structure we check for each cat
--- high ----
--- med ---
--- low ---
-- informational---
award ----
ranks H, M, L , I

--award -- proposal(winning xp, some actual money )
validate(solution)


### zktls && workflow

 