// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WorkFlow is ERC20{
IERC20 vaLit;
//uint256 amountTomint;
address owner;
    constructor(uint256 _amountTomint/*, address _owner*/) ERC20("vaLiT", "VT") {
        owner = msg.sender;
        _mint(address(owner), _amountTomint); // um change it 
    }


    //1. a way to grade contributions
    //2.ranking of contribution high, medium, low, informational
    //3. who will rank? reviewers

    //contribute ----> zktls validate -----> workflow rank 
    // how is the rank going to be graded?
    // are we using automation or humans / manual? yes actual validators 
 
//xp ---- valid we give them ep...... and if they sumbit invalitor .... we minus 
 //judes validators .......

 struct ValidatorParam{
    string feedback;
    bool isVald;
 }

 mapping(address => ValidatorParam) public validationInfo;


 bool activeValidation;

    function addValidator() external{}
    function hasBeenValidated(uint256 _contributionHash) public view returns(bool) {}

//anyone can remove validator if they have no rewards, cannot remove if theyre actively validating a contribution
    function removeVAlidator() external {}


// zktls proof the validator work

   function validatePOW() external {}

   function getValidatorreputation () external {}

   function validate() external {}

// swap validator erc for the ld token/ xp token
   function swap() external {}

// compere the valid/ good bad/ invarid <
   function getvalidation() public {
    
   }

// tell us what type it is documat............
// importnat in contri --- documention, addi
// spelling mistakes 
//////////

// validation ------- contribute ---- proof 
// validation logic ?
// validator validation being validated

/////////////////////////////////////////////////////////////////////////
////////////////ranking Logic///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

function high() external /*onlyValidator*/ {}

function med() external {}

function low() external{}

function informational() external {}

//13 good, 7 bad 
// 13
// contributor -> (high, med, low)  



}