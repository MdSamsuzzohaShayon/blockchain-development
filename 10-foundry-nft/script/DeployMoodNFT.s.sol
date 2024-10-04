// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol"; // Foundry's Script utility and console for debugging
import {MoodNFT} from "src/MoodNFT.sol"; // Import the MoodNFT contract that we previously created
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol"; // Base64 encoding utility from OpenZeppelin

/**
 * This contract is a deployment script for the MoodNFT contract using Foundry.
 * It reads SVG image files from the file system, converts them into a Base64 image URI,
 * and deploys the MoodNFT contract with the image URIs as constructor parameters.
 */
contract DeployMoodNFT is Script {
    /**
     * The `run()` function is the main function that Foundry uses to execute the deployment script.
     * It reads the SVG files, converts them to Base64 encoded image URIs, and then deploys the MoodNFT contract.
     * It returns an instance of the deployed MoodNFT contract.
     */
    function run() external returns (MoodNFT) {
        // Read the contents of the 'sad.svg' and 'happy.svg' files into string variables
        // Foundry's cheat code 'vm.readFile' is used to read files from the filesystem.
        string memory sadSvg = vm.readFile("img/sad.svg");
        string memory happySvg = vm.readFile("img/happy.svg");

        // Optional: These lines are commented out but can be used to log the SVG contents to the console for debugging.
        // console.log(sadSvg);
        // console.log(happySvg);

        // Start recording a transaction. Foundry's `startBroadcast()` allows us to send a transaction.
        vm.startBroadcast();
        
        // Deploy the MoodNFT contract, passing the Base64 encoded image URIs to the constructor.
        MoodNFT moodNft = new MoodNFT(svgToImageURI(sadSvg), svgToImageURI(happySvg));

        // Stop recording the transaction. `stopBroadcast()` tells Foundry to stop simulating/sending transactions.
        vm.stopBroadcast();

        // Return the instance of the newly deployed MoodNFT contract.
        return moodNft;
    }

    /**
     * Converts an SVG string to a Base64 encoded image URI.
     * The resulting URI can be used in a web browser or as metadata for NFTs.
     *
     * @param svg The SVG image string.
     * @return A string representing the Base64 encoded image URI.
     */
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        // The base URI for SVG images in the 'data' scheme.
        string memory baseURL = "data:image/svg+xml;base64,";
        
        // Encode the SVG string to Base64 format. The 'bytes()' cast is necessary to handle string to byte conversion.
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        // Return the final data URI by concatenating the base URL and the Base64 encoded SVG content.
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
