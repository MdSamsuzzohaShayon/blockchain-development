// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;


  /**
    * A contract can have at most one receive function, declared using receive() 
    * external payable { ... } (without the function keyword). This function cannot 
    * have arguments, cannot return anything and must have external visibility and 
    * payable state mutability. It can be virtual, can override and can have 
    * modifiers.The receive function is executed on a call to the contract with 
    * empty calldata. This is the function that is executed on plain Ether 
    * transfers (e.g. via .send() or .transfer()). If no such function exists, 
    * but a payable fallback function exists, the fallback function will be 
    * called on a plain Ether transfer. If neither a receive Ether nor a payable 
    * fallback function is present, the contract cannot receive Ether through a 
    * transaction that does not represent a payable function call and throws an exception.
    * https://docs.soliditylang.org/en/latest/contracts.html#special-functions
    */

contract FallbackExample{
    uint256 public result;

    /**
     * If we do not put any data to call data this function will be called
     * Nevertheless, If we put any data fallback function will be called
     */
    receive() external payable{
        result = 1;
    }

    /**
     * 05:52:16 - https://youtu.be/umepbfKp5rI?t=21136
     * When we put something on calldata and transact it will call this fallback function by default
     * Example: put 0x00 on calldata
     */
    fallback() external payable{
        result = 2;
    }
}


/**
 * Ether is sent to contract
 *                      is msg.data empty?
 *                          /   \
 *                      Yes     No
 *                     /         \
 *                 receive()?    fallback?
 *                  /   \
 *               Yes    No
 *               /       \
 *           receive()  fallback()
 */


// https://youtu.be/umepbfKp5rI?t=20979