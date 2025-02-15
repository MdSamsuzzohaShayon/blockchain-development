// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Dappazon {
    string public name;
    address public owner;



    constructor(){
        name = "Dappazon";
        owner = msg.sender; // Who deploy the smart contract
    }
}
