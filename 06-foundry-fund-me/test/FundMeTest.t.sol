// SPDX-Licence-Identifier: MIT
pragma solidity 0.8.19;

// https://book.getfoundry.sh/forge/tests

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMeTest is Test{
    // uint256 num = 1;
    FundMe fundMe;

    // Create fake address - https://book.getfoundry.sh/reference/forge-std/make-addr
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        // num = 2;

        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        // Sets the balance of an address who to newBalance. https://book.getfoundry.sh/cheatcodes/deal
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinDollarsIsFive() public{
        // console.log(num);
        // assertEq(num, 2);
        assertEq(fundMe.MIN_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public{
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersion() public{
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    // https://book.getfoundry.sh/cheatcodes/expect-revert
    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        // uint256 cat = 1; // this will pass
        fundMe.fund();
    }

    function testFoundUpdatesFundedDataStructure() public{
        // Sets msg.sender to the specified address for the next call. https://book.getfoundry.sh/cheatcodes/prank
        // Next TX will be sent by USER
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    // [01:17:00] - https://youtu.be/sas02qSFZ74?t=4671
    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }


    modifier funded(){
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded{
        // vm.prank(USER);
        // fundMe.fund{value: SEND_VALUE}();

        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }
    
}