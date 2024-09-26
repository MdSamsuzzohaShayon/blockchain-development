// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title BasicNFT
 * @dev A simple NFT contract based on the ERC721 standard. This contract allows minting of unique tokens (NFTs).
 * @dev It uses OpenZeppelin's ERC721 implementation for the NFT functionality.
 * 
 * @notice Non-Fungible Tokens (NFTs) are unique digital assets stored on a blockchain. 
 * Unlike fungible tokens (like Ether), which are interchangeable, NFTs are unique and indivisible. 
 * NFTs are widely used to represent ownership of digital or physical assets, such as art, music, and other collectibles.
 *
 * Links for reference:
 * - OpenZeppelin ERC721: https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721
 * - OpenZeppelin Documentation: https://docs.openzeppelin.com/contracts/5.x/api/token/erc721
 * - ERC-721 Standard (Ethereum Improvement Proposal): https://eips.ethereum.org/EIPS/eip-721
 * - Ethereum Documentation on ERC-721: https://ethereum.org/en/developers/docs/standards/tokens/erc-721/
 * 
 * @notice The NFTs in this contract can reference digital files like images and metadata stored on IPFS.
 * Example:
 * - Metadata file (JSON): ipfs://QmNhBXAK9sZWJFUQHkEZVFvW2c4RiUuw2ApFuKtdh82hMQ/?filename=1.json
 * - Original file (image): ipfs://QmazuTtERYQ51ffUC8gvK4zuXfMbk9gRVYJh9c9eu2pzss/?filename=1.jpg
 */

// Importing the OpenZeppelin ERC721 standard implementation.
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title BasicNFT Contract
 * @dev The contract allows minting of NFTs where each NFT is associated with a unique token URI (metadata).
 * The token URI points to off-chain storage like IPFS, where the asset data is stored.
 * The contract extends the ERC721 standard provided by OpenZeppelin.
 */
contract BasicNFT is ERC721 {

    /**
     * @dev s_tokenCounter keeps track of the number of NFTs minted.
     * Each minted token gets a unique `tokenId` starting from 0, which increments with each new token.
     */
    uint256 private s_tokenCounter;

    /**
     * @dev A mapping from tokenId to the token URI (metadata) for each NFT.
     * The token URI typically points to metadata that describes the NFT and might include links to the actual digital assets (e.g., an image or video).
     * Example of token URI: ipfs://<hash>/filename.json
     */
    mapping(uint256 => string) private s_tokenIdToUri;

    /**
     * @notice Constructor initializes the contract by setting the token name and symbol.
     * @dev The ERC721 constructor is called with two parameters: the name and symbol of the token.
     * - Name: "Dogie"
     * - Symbol: "DOG"
     * 
     * @dev The s_tokenCounter is initialized to 0, which means the first minted NFT will have a token ID of 0.
     */
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /**
     * @notice Function to mint a new NFT.
     * @param _tokenUri The metadata URI for the NFT being minted. This URI typically points to an IPFS location where the NFT metadata is stored.
     * @dev This function creates a new NFT, assigns it a `tokenId`, and stores the metadata URI for the newly minted NFT.
     * - The `tokenId` is the current value of `s_tokenCounter`.
     * - The new NFT is minted to the address of the function caller (`msg.sender`).
     * - The `_safeMint` function is used to safely mint the token, ensuring that the recipient can handle ERC721 tokens.
     * - After minting, the token counter (`s_tokenCounter`) is incremented by 1.
     */
    function mintNft(string memory _tokenUri) public {
        // Assign the provided URI to the new token ID
        s_tokenIdToUri[s_tokenCounter] = _tokenUri;

        // Safely mint the new token with the current token ID and assign it to the caller (msg.sender)
        _safeMint(msg.sender, s_tokenCounter);

        // Increment the token counter for the next minted token
        s_tokenCounter++;
    }

    /**
     * @notice Override function to return the URI (metadata) for a specific tokenId.
     * @param _tokenId The ID of the token for which the URI is being queried.
     * @return A string representing the token's URI.
     * @dev This function overrides the default `tokenURI` function from the ERC721 standard.
     * It retrieves the URI for a specific tokenId from the `s_tokenIdToUri` mapping.
     * The returned URI typically points to the metadata for the NFT, such as JSON metadata stored on IPFS.
     * Example of a token URI: ipfs://<hash>/filename.json
     */
    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        // Return the token URI for the given token ID
        return s_tokenIdToUri[_tokenId];
    }
}
