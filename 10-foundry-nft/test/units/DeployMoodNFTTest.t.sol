// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol"; // Importing Foundry's Test library for testing and console for debugging
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol"; // Importing the DeployMoodNFT contract

/**
 * @title DeployMoodNFTTest
 * This contract is a test suite for the DeployMoodNFT contract using Foundry's testing framework.
 * It verifies the correctness of the `svgToImageURI` function by converting an SVG string to a Base64-encoded image URI.
 */
contract DeployMoodNFTTest is Test {
    // State variable to hold an instance of the DeployMoodNFT contract
    DeployMoodNFT public deployer;

    /**
     * The `setUp()` function is called before each test case to initialize the contract.
     * It instantiates a new DeployMoodNFT contract to be used in the test cases.
     */
    function setUp() public {
        deployer = new DeployMoodNFT(); // Creates a new instance of DeployMoodNFT
    }

    /**
     * @dev This test verifies the `svgToImageURI()` function of the DeployMoodNFT contract.
     * It compares the Base64-encoded URI generated from an SVG string with an expected hardcoded Base64 value.
     */
    function testConvertSvgToUri() public view {
        // This is the expected Base64-encoded URI for the SVG image (precomputed)
        // It starts with the `data:image/svg+xml;base64,` scheme followed by the Base64-encoded content.
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0iI2YwZjBmMCIvPjxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM0Q0FGNTAiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSI0Ii8+PHBvbHlnb24gcG9pbnRzPSIxMDAsNDAgMTIwLDgwIDE2MCw4MCAxMzAsMTEwIDE0MCwxNTAgMTAwLDEzMCA2MCwxNTAgNzAsMTEwIDQwLDgwIDgwLDgwIiBmaWxsPSIjRkY1NzIyIiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iMyIvPjx0ZXh0IHg9IjUwJSIgeT0iMTgwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMjAiIGZpbGw9IiMzMzMiPk15IE5GVDwvdGV4dD48L3N2Zz4=";

        // The actual SVG string to be converted to a Base64-encoded URI
        string memory svg =
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200"><rect width="100%" height="100%" fill="#f0f0f0"/><circle cx="100" cy="100" r="80" fill="#4CAF50" stroke="#333" stroke-width="4"/><polygon points="100,40 120,80 160,80 130,110 140,150 100,130 60,150 70,110 40,80 80,80" fill="#FF5722" stroke="#333" stroke-width="3"/><text x="50%" y="180" text-anchor="middle" font-family="Arial" font-size="20" fill="#333">My NFT</text></svg>';

        // Call the `svgToImageURI()` function from the DeployMoodNFT contract to convert the SVG to a Base64 URI
        string memory actualUri = deployer.svgToImageURI(svg);

        // Use `assert()` to compare the generated URI with the expected URI.
        // The `keccak256()` function is used to hash both strings before comparing them to handle potential formatting differences.
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }
}
