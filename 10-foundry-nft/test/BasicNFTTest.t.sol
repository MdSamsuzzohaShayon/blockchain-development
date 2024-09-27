// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Importing necessary contracts from external libraries
import {Test} from "forge-std/Test.sol"; // Importing the Test contract for testing functionality
import {BasicNFT} from "src/BasicNFT.sol"; // Importing the BasicNFT contract to be tested
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol"; // Importing the deployment script for BasicNFT

/**
 * @title BasicNFTTest
 * @dev This contract is designed to test the BasicNFT contract functionalities.
 */
contract BasicNFTTest is Test {
    DeployBasicNFT public deployer; // Variable to hold the deployer instance
    BasicNFT public basicNft; // Variable to hold the instance of the BasicNFT
    address public USER = makeAddr("user"); // Creating a mock user address for testing
    string public constant ONE = "ipfs://QmNhBXAK9sZWJFUQHkEZVFvW2c4RiUuw2ApFuKtdh82hMQ/?filename=1.json"; // URI for the NFT metadata

    /**
     * @dev Set up the testing environment before each test case.
     * This function initializes the DeployBasicNFT and BasicNFT instances.
     * Why? We need to create instances of the contracts to interact with them in our tests.
     */
    function setUp() public {
        deployer = new DeployBasicNFT(); // Instantiating the deployer to deploy the NFT contract
        basicNft = deployer.run(); // Running the deployer to get the deployed BasicNFT instance
    }

    /**
     * @dev Test to ensure the name of the NFT is correct.
     * This checks that the BasicNFT contract has the correct name as expected.
     * Why? It's important to verify that the contract's state is set up correctly.
     */
    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie"; // The expected name of the NFT
        string memory actualName = basicNft.name(); // Fetching the actual name from the NFT contract
        // Comparing the expected name with the actual name using hash to avoid string comparison issues
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    /**
     * @dev Test to check if minting an NFT works and updates the user's balance correctly.
     * This function mints an NFT for the mock user and checks the balance.
     * Why? We need to ensure that the minting function works as intended and that the user’s balance reflects the minting action.
     */
    function testCanMintAndHaveABalance() public {
        vm.prank(USER); // Simulating the user calling the mint function
        basicNft.mintNft(ONE); // Minting an NFT with the specified token URI
        assert(basicNft.balanceOf(USER) == 1); // Checking if the user's balance is updated to 1
        // Ensuring the token URI of the minted NFT matches the expected URI
        assert(keccak256(abi.encodePacked(ONE)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
