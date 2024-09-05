// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

/**
 * Solidity supports multiple inheritance including polymorphism.
 * https://docs.soliditylang.org/en/v0.8.25/contracts.html#inheritance
 * Use `is` to derive from another contract.
 * contracts can access all non-private members including
 * internal functions and state variables. These cannot be accessed externally via `this`, though.
 */
contract AddFiveStorage is SimpleStorage{
    function sayHello() public pure returns(string memory){
        return "Hello";
    }

    /**
     * Base functions can be overridden by inheriting contracts to change their behavior if they are marked as virtual. The overriding function must then use the override keyword in the function header.
     * https://docs.soliditylang.org/en/v0.8.25/contracts.html#function-overriding
     * If you want the function to override, you need to use the `override` keyword. You need to specify the `virtual` keyword again if you want this function to be overridden again.
     */
     function store(uint256 _newNumber) public override{
        myFavoriteNumber = _newNumber + 5;
     }
}
