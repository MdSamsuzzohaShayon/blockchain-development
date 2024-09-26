// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";


contract BasicNFTTest is Test{
    DeployBasicNFT public deployer;
    BasicNFT public basicNft;
    address public USER = makeAddr("user");
    string public constant ONE = "ipfs://QmNhBXAK9sZWJFUQHkEZVFvW2c4RiUuw2ApFuKtdh82hMQ/?filename=1.json";

    function setUp() public{
        deployer = new DeployBasicNFT();
        basicNft = deployer.run();
    }
    function testNameIsCorrect() public view{
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol
        // In solidity, string is array of bytes, therefore, whether we need need to match using loop or we can use hash of the string
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }
    function testCanMintAndHaveABalance() public{
        vm.prank(USER);
        basicNft.mintNft(ONE);
        assert(basicNft.balanceOf(USER)==1);
        assert(keccak256(abi.encodePacked(ONE)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

    }
}