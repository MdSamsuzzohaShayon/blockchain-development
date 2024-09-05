// SPDX-Licence-Identifier: MIT
pragma solidity 0.8.19;

// https://book.getfoundry.sh/forge/tests

import {Test} from "forge-std/Test.sol";

contract FundMeTest is Test{
    uint256 num = 1;
    function setUp() external {
        num = 2;
    }

    function testDemo() public{
        assertEq(num, 2);
    }
}