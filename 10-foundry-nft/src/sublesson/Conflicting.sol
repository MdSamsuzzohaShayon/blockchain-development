// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Conflicting{
    // TypeError: Function signature hash collision for gasprice_bit_ether(int128)
    // The error occurs because there is a conflict in function signature hashes. In Solidity, each function has a unique signature hash, which is used to identify the function. When you define multiple functions with the same name but different parameter types, Solidity can't generate a unique signature hash for them.
    // In your case, you have two functions: `transferFrom` and `gasprice_bit_ether`. However, you're using the same name `gasprice_bit_ether` for two functions with different parameter types: `function gasprice_bit_ether(int128)` and the other one is missing the parameter type.

    function transferFrom(address hi, address hello, uint256 sup) public{

    }

    function gasprice_bit_ether(int128)public{

    }
}