// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Importing necessary libraries and contracts from OpenZeppelin for safe token management and metadata storage.
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/*
 * @title RealEstate NFT Contract
 * @notice This contract enables users to mint NFTs representing unique real estate properties.
 * Each NFT functions like a digital deed, allowing users to track ownership of individual properties.
 * @dev This contract uses OpenZeppelin's Counters library for secure token ID management
 *      and ERC721URIStorage to handle metadata for each NFT.
 */
contract RealEstate is ERC721URIStorage {
    using Counters for Counters.Counter;  // Integrating Counters library to manage token ID counting.
    Counters.Counter private _tokenIds;   // Private variable to keep track of current token IDs.

    /*
     * @notice Constructor to initialize the NFT contract with a name and symbol.
     * @dev Sets the name to "Real Estate" and the symbol to "REAL", using the ERC721 constructor.
     */
    constructor() ERC721("Real Estate", "REAL") {}

    /*
     * @notice Mints a new real estate NFT with a unique token ID and metadata URI.
     * @param tokenURI A string representing the URI containing metadata about the property (e.g., image, details).
     * @return uint256 The unique ID of the minted NFT.
     * 
     * @dev Increments the token ID counter each time a new token is minted.
     * Example usage: A user calls `mint` with a metadata URL to create an NFT representing a specific property.
     * 
     * How it works:
     * - Each new property is assigned a unique ID (like a deed or title).
     * - Metadata (such as images, location, or descriptions) can be accessed through the URI.
     */
    function mint(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();                       // Incrementing token ID for uniqueness.
        
        uint256 newItemId = _tokenIds.current();     // Setting new token ID based on the current counter.
        _mint(msg.sender, newItemId);                // Minting the token and assigning it to the caller's address.
        _setTokenURI(newItemId, tokenURI);           // Setting metadata URI for the newly minted token.

        return newItemId;                            // Returning the new token's unique ID to the caller.
    }

    /*
     * @notice Returns the total number of tokens minted by the contract.
     * @return uint256 The total supply of NFTs created, serving as a record of all minted properties.
     * 
     * @dev Example usage: A user or marketplace could call `totalSupply` to display the number of available tokens.
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();                  // Returning the current count of tokens created.
    }
}
