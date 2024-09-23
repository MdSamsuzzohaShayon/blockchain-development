// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721
 * https://docs.openzeppelin.com/contracts/5.x/api/token/erc721
 * https://eips.ethereum.org/EIPS/eip-721
 * https://ethereum.org/en/developers/docs/standards/tokens/erc-721/
 */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory _tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter ++;
    }

    // lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol
    function tokenURI(uint256 tokenId) public view override returns(string memory){
        // ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json
        return s_tokenIdToUri[tokenId];
    }
}
