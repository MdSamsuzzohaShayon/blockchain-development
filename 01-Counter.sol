// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    /*
     * State variable: State variables are variables whose values are permanently stored in contract storage.
     * Docs: https://docs.soliditylang.org/en/v0.8.27/structure-of-a-contract.html#state-variables
     */

     uint public count = 0; 

     function incrementCount() public{
        count ++;
     }
}