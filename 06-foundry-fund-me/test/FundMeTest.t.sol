// SPDX-Licence-Identifier: MIT
pragma solidity 0.8.19;

// https://book.getfoundry.sh/forge/tests

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";


contract FundMeTest is Test{
    // uint256 num = 1;
    FundMe fundMe;

    function setUp() external {
        // num = 2;

        fundMe = new FundMe();
    }

    function testMinDollarsIsFive() public{
        // console.log(num);
        // assertEq(num, 2);
        assertEq(fundMe.MIN_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public{
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedVersion() public{
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    
}