// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract SampleToken is ERC20 {
    constructor(uint initialSupply, string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
}
