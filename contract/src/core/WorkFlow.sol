// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Dao.sol";

contract WorkFlow is ERC20{
IERC20 vaLit;
Dao public dao;
//uint256 amountTomint;
address owner;
    constructor(uint256 _amountTomint/*, address _owner*/) ERC20("vaLiT", "VT") {
        owner = msg.sender;
        _mint(address(this), _amountTomint); // um change it 
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
    uint60 time;
    bool isactiveValidator;
    uint256 reward;
    uint256 penalty;
    uint256 numberOFContributorvalidated
 }

 mapping(address => ValidatorParam) public validationInfo;
validators[] _validators;

 bool activeValidation;
 bool isvalidator;
 mapping(address => ValidatorParam => ContributionInfo) public validatorToContributor;

    function addValidator(address _validator) external{
      require(_validator != address(0));
      _validators.push(_validator);
      isvalidator = true;

    }
    function hasBeenValidated(uint256 _contributionHash) public view returns(bool) {
      //validatorToContributor[]
    }

//anyone can remove validator if they have no rewards, cannot remove if theyre actively validating a contribution
    function removeVAlidator(address _validator) external {
     
    }


// zktls proof the validator work


   function getValidatorreputation (address validatorAddress) public view returns(ValidatorParam memory) {
      return ValidatorParam.reward , ValidatorParam.numberOFContributorvalidated, ValidatorParam.penalty;
   }


   function validate(string memory _feedback, bool _isVald) external returns(ValidatorParam memory) {
      if(!isvalidator){
         revert WorkFlow__MustBeAvalidator;
      }
      validationInfo[msg.sender] = ValidatorParam({
         feedback :_feedback ;
         isVald :_isVald ;
         time : block.timestamp;
         isactiveValidator : true;
         reward : 0;
         penalty : 0;
         numberOFContributorvalidated :  numberOFContributorvalidated + 1;

      })

  return ValidatorParam.isVald, ValidatorParam.feedback;
   }

   function validatePOW() external {}
// swap validator erc for the ld token/ xp token
   function swap(uint256 amount, address to) external {
     ValidatorParam memory info = validationInfo[to];
       uint256 _amount = info.reward;
       require(amount <= _amount, "WorkFlow__Not_Enough_Balance");
     //  dao.
     //burn validator token and mint xp
     


        }

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