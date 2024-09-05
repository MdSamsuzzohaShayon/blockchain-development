// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { Test, console } from "forge-std/Test.sol";

/**
 * Forge can run your tests with the forge test command. All tests are written in Solidity.
 * https://book.getfoundry.sh/forge/tests
 *
 * Tests are written in Solidity. If the test function reverts, the test fails, otherwise it passes.
 * https://book.getfoundry.sh/forge/writing-tests
 * setUp: An optional function invoked before each test case is run. (ity always runs first)
 * test: Functions prefixed with test are run as a test case.
 *
 * Console Logging
 *      Similar to Hardhat’s console functions.
 *      You can use it in calls and transactions. It works with view functions, but not in pure ones.
 *      It always works, regardless of the call or transaction failing or being successful.
 *      To use it you need import it:
 *      import "forge-std/console.sol";
 */
contract FundMeTest is Test{
    uint256 number = 1;

    function setUp() external{
        number = 2;
    }

    function test_Demo() public view{
        assertEq(number, 2);
    }
}