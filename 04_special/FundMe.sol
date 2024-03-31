// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MIN_USD = 50 * 1e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

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


     modifier onlyOwner(){
        // require(msg.sender == i_owner, "Owner is not sender!");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
     }


    /**
     * If somebody send money without calling fund function it will automitically route them to fund function
     */
     receive() external payable{
        fund();
     }

     fallback() external payable{
        fund();
     }

}


// 05:34:00 https://youtu.be/umepbfKp5rI?t=20079
// Recap 05:55:00 https://youtu.be/umepbfKp5rI?t=21436

