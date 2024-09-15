//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.5/contracts/token/ERC721/ERC721.sol
// node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol
// ERC721 is the standard for creating non-fungible tokens (NFTs).
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.5/contracts/token/ERC721/extensions/ERC721URIStorage.sol
// node_modules/@openzeppelin/contracts/utils/Counters.sol
// This extension allows storing metadata (like images, attributes) using URIs for each token.
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/**
 * @title RealEstate
 * @dev This contract allows minting of ERC-721 tokens representing real estate properties.
 * Each property has its own unique metadata stored as a URI (Uniform Resource Identifier).
 * The contract inherits functionality from OpenZeppelin's ERC721 and ERC721URIStorage.
 * @notice This contract can mint unique NFTs that represent real estate properties with associated metadata.
 * https://docs.openzeppelin.com/contracts/5.x/erc721
 */
contract RealEstate is ERC721URIStorage {
    // State variable to keep track of the next token ID for minting.
    // This ensures each token has a unique ID, starting from 0.
    uint256 private s_nextTokenId;

    /**
     * @dev Constructor for the RealEstate contract.
     * It sets the name of the token to "Real Estate" and the symbol to "REAL".
     * @notice The constructor initializes the ERC721 contract with the token name and symbol.
     */
    constructor() public ERC721("Real Estate", "REAL") {}

    /**
     * @dev Function to mint a new NFT representing a real estate property.
     * @param player The address that will receive ownership of the minted NFT.
     * @param tokenURI The metadata URI for the NFT (e.g., JSON file with details about the property).
     * @return tokenId The ID of the newly minted token.
     * @notice This function allows the caller to mint a new real estate NFT with a specific URI.
     * @dev The `_mint` function from ERC721 is used to create the token, and `_setTokenURI` assigns metadata to it.
     */
    function mint(
        address player,
        string memory tokenURI
    ) public returns (uint256) {
        // Assign the current token ID and increment for the next token.
        uint256 tokenId = s_nextTokenId++;

        // Mint the token for the player address with the assigned token ID.
        // `_mint` is inherited from the ERC721 standard.
        _mint(player, tokenId);

        // Set the token's URI (metadata) for the newly minted token.
        // `_setTokenURI` is inherited from ERC721URIStorage, allowing each token to have a unique URI.
        _setTokenURI(tokenId, tokenURI);

        // Return the newly minted token's ID.
        return tokenId;
    }

    /**
     * @dev Function to get the total supply of minted tokens.
     * @return uint256 The total number of tokens that have been minted.
     * @notice This function provides the total count of NFTs minted so far.
     * @dev It returns the value of the `s_nextTokenId` state variable, which tracks the number of minted tokens.
     */
    function totalSupply() public view returns (uint256) {
        return s_nextTokenId;
    }
}

