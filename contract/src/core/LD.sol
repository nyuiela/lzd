// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {OFT} from "@layerzerolabs/oft-evm/contracts/OFT.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract LD is OFT {
    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndPoint,
        address _delegate,
        uint256 initialMintAmount
    ) OFT(_name, _symbol, _lzEndPoint, _delegate) Ownable(_delegate) {}

    // this is our custom token

    function transfer(
        address to,
        uint256 _amount
    ) public override returns (bool) {
        return super.transfer(to, _amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 _amount
    ) public override returns (bool) {
        return super.transferFrom(from, to, _amount);
    }
}
