// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title BasicNFTTest Contract
 * @dev This contract contains unit tests for the `BasicNFT` contract.
 * It uses Foundry's `Test` contract to create and run automated tests.
 * This contract verifies that the NFT behaves correctly when deployed and interacted with.
 *
 * Foundry is a popular framework for testing and deploying Solidity contracts, and `Test.sol`
 * provides a variety of tools to make testing smart contracts easy and efficient.
 *
 * Links for reference:
 * - Foundry Documentation: https://book.getfoundry.sh/
 * - Test.sol: https://github.com/foundry-rs/forge-std/blob/master/src/Test.sol
 */

// Importing Foundry's Test contract to utilize its testing framework.
import {Test} from "forge-std/Test.sol";

// Importing the BasicNFT contract to test its functionality.
import {BasicNFT} from "src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
// Importing the DeployBasicNFT contract to automate the deployment of BasicNFT for testing.
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";

/**
 * @title BasicNFTTest Contract
 * @dev This contract contains tests for the BasicNFT contract, ensuring it behaves as expected.
 * It uses functions from the Foundry `Test` contract to facilitate testing.
 */
contract BasicNFTTest is Test {
    // State variables
    DeployBasicNFT public deployer; // Instance of the DeployBasicNFT contract used to deploy BasicNFT.
    BasicNFT public basicNft; // Instance of the deployed BasicNFT contract.
    address public USER = makeAddr("user"); // Test address representing a user.
    string public constant ONE = "ipfs://QmNhBXAK9sZWJFUQHkEZVFvW2c4RiUuw2ApFuKtdh82hMQ/?filename=1.json"; // Example token URI.

    /**
     * @dev The `setUp` function is run before each test case. It deploys the BasicNFT contract
     *      and prepares the environment for testing.
     * @notice This function will initialize the contract instances that will be used in the tests.
     */
    function setUp() public {
        // Deploy the DeployBasicNFT contract.
        deployer = new DeployBasicNFT();

        // Call the `run` function from the DeployBasicNFT contract to deploy the BasicNFT contract.
        basicNft = deployer.run();
    }

    /**
     * @notice Tests that the name of the BasicNFT contract is correct.
     * @dev This function verifies if the `name` function from the BasicNFT contract returns the expected value.
     *      In Solidity, strings are stored as an array of bytes, so to compare strings, we must use `keccak256` hashing.
     */
    function testNameIsCorrect() public view {
        // The expected name of the NFT collection.
        string memory expectedName = "Dogie";

        // The actual name of the NFT collection returned by the BasicNFT contract.
        string memory actualName = basicNft.name();

        // Assert that the hashed value of the expected name and actual name are the same.
        // Using `keccak256` to hash the strings for comparison because string comparison in Solidity requires hashing.
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    /**
     * @notice Tests that a user can mint an NFT and their balance increases accordingly.
     * @dev This function simulates a user minting an NFT and checks if the NFT is successfully minted
     *      by verifying the balance and the token URI.
     *      It uses `vm.prank` from Foundry to simulate the minting transaction as a different address.
     */
    function testCanMintAndHaveABalance() public {
        // Simulate `USER` as the caller of the mint function (acting on behalf of the `USER` address).
        vm.prank(USER);

        // Mint a new NFT with the specified token URI.
        basicNft.mintNft(ONE);

        // Assert that the balance of the `USER` is 1 after minting the NFT.
        assert(basicNft.balanceOf(USER) == 1);

        // Assert that the token URI of the minted NFT matches the expected token URI.
        assert(keccak256(abi.encodePacked(ONE)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
