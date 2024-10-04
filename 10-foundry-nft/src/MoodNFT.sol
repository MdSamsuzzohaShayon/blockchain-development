// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * MoodNFT allows the mood of an NFT to change dynamically.
 * If the NFT's face is happy, it can be made sad; if sad, it can be made happy.
 * This contract uses two SVG images to represent the moods and stores them on-chain.
 */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

// arweave.org - decentralized metadata storage
// filecoin.io - decentralized storage
// nft.storage - service for storing NFTs off-chain in a decentralized way

contract MoodNFT is ERC721 {
    // Custom error to handle mood flipping permissions
    error MoodNFT__CanNotFlipMood();

    // State variables
    uint256 private s_tokenCounter; // Counter to keep track of token IDs
    string private s_sadSvgImgUri;  // URI for the "sad" SVG image
    string private s_happySvgImgUri; // URI for the "happy" SVG image

    // Enum representing the possible moods of the NFT
    enum Mood {
        HAPPY,  // 0
        SAD     // 1
    }

    // Mapping of each token ID to its corresponding mood
    mapping(uint256 => Mood) private s_tokenIdToMood;

    /**
     * Constructor to initialize the contract with two image URIs and token name and symbol.
     * The two URIs represent the "happy" and "sad" moods.
     */
    constructor(string memory sadSvgImgUri, string memory happySvgImgUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0; // Initialize token counter
        s_sadSvgImgUri = sadSvgImgUri;   // Store sad image URI
        s_happySvgImgUri = happySvgImgUri; // Store happy image URI
    }

    /**
     * Mint a new NFT with the initial mood set to HAPPY.
     * This function mints the NFT and assigns the happy mood to the token.
     * The token ID increments with each mint.
     */
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter); // Mint the NFT safely to the sender
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; // Set the mood of the newly minted NFT to HAPPY
        s_tokenCounter++; // Increment the token counter for future mints
    }

    /**
     * Allows the NFT owner (or an approved operator) to change the NFT's mood.
     * If the current mood is HAPPY, it will switch to SAD, and vice versa.
     * Only the owner or an approved address can flip the mood.
     */
    function flipMood(uint256 tokenId) public {
        // Check if the sender is the owner or has approval to manage the token
        bool isApprovedOrOwner = (
            getApproved(tokenId) == msg.sender || isApprovedForAll(ownerOf(tokenId), msg.sender)
                || ownerOf(tokenId) == msg.sender
        );
        
        // If the caller isn't authorized, revert the transaction with a custom error
        if (!isApprovedOrOwner) {
            revert MoodNFT__CanNotFlipMood();
        }

        // Flip the mood of the token: if HAPPY, switch to SAD; if SAD, switch to HAPPY
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    /**
     * Override the base URI used for metadata generation.
     * Here we return a base64 encoded JSON string that represents the metadata.
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /**
     * Generates and returns the metadata for a given token ID.
     * This includes the NFT's name, description, traits (e.g., mood), and an SVG image URI.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;

        // Determine which image URI to use based on the token's current mood
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImgUri;
        } else {
            imageURI = s_sadSvgImgUri;
        }

        // Construct the metadata JSON and encode it in base64
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting is technically unnecessary here, but adds clarity
                        abi.encodePacked(
                            '{"name":"',
                            name(), // The name of the token collection (e.g., "Mood NFT")
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
