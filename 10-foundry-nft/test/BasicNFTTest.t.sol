// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";


contract BasicNFTTest is Test{
    DeployBasicNFT public deployer;
    BasicNFT public basicNft;

    function setUp() public{
        deployer = new DeployBasicNFT();
        basicNft = deployer.run();
    }
}