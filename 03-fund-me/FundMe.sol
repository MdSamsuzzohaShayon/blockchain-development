// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

error NotoOwner();

contract FundMe {
    using PriceConverter for uint256;

    /**
     * State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time.
     * For constant variables, the value has to be a constant at compile time and it has to be assigned where the variable is declared. 
     * https://docs.soliditylang.org/en/latest/contracts.html#constant
     * Transaction cost: Gas used before without using constant 853,039 -> optimized gas used 790,344 using constant
     * Execution cost: Gas used before without using constant 2407 -> optimized gas used 307 using constant for viewing MIN_USD variable 
     */
    uint256 public constant MIN_USD = 50 * 1e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

    /**
     * Variables declared as immutable are a bit less restricted than those declared 
     * as constant: Immutable variables can be assigned a value at construction time. 
     * The value can be changed at any time before deployment and then it becomes permanent.
     * https://docs.soliditylang.org/en/latest/contracts.html#immutable
     * i_owner immutable cost 444, i_owner non immutable cost 2580
     */
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() > MIN_USD,
            "Didn't send enough ETH!"
        ); 

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {

        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
    }


    /**
     * Starting from Solidity v0.8.4, there is a convenient and gas-efficient way to explain to users why an operation failed through the use of custom errors. 
     * https://soliditylang.org/blog/2021/04/21/custom-errors/
     */
     modifier onlyOwner(){
        // require(msg.sender == i_owner, "Owner is not sender!");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
     }

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

}


// 05:34:00 https://youtu.be/umepbfKp5rI?t=20079

