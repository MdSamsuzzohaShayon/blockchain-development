// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";
import {OurToken} from "src/OurToken.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OutTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    // https://docs.openzeppelin.com/contracts/2.x/api/token/erc20
    // https://docs.openzeppelin.com/contracts/2.x/api/token/erc20#IERC20-transferFrom-address-address-uint256-
    function testAllowancesWorks() public {
        uint256 initialAllowances = 1000;
        // Bob approves Alice to spend tokens on her behalf
        vm.prank(bob);
        // lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol
        ourToken.approve(alice, initialAllowances);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    /// @dev Test initial token supply is correctly minted.
    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    /// @dev Test that users cannot mint tokens if they are not the owner.
    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testBalanceAfterTransfer() public {
        uint256 amount = 1000;
        address receiver = address(0x1);
        uint256 initialBalance = ourToken.balanceOf(msg.sender);
        vm.prank(msg.sender);
        ourToken.transfer(receiver, amount);
        assertEq(ourToken.balanceOf(msg.sender), initialBalance - amount);
    }

    /// @dev Test approving allowances and checking the allowance value.
    function testAllowanceApproval() public {
        uint256 amount = 300;

        vm.prank(bob);
        ourToken.approve(alice, amount); // bob approves alice to spend on their behalf

        assertEq(ourToken.allowance(bob, alice), amount);
    }

    function testTransferFrom() public {
        uint256 amount = 1000;
        address receiver = address(0x1);
        vm.prank(msg.sender);
        ourToken.approve(address(this), amount);
        ourToken.transferFrom(msg.sender, receiver, amount);
        assertEq(ourToken.balanceOf(receiver), amount);
    }
}
