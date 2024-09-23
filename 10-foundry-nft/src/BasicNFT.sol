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

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft() public {}

    // lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol
    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return "ipfs://bafybeif3m7vdqkjs5nysm6qe2sl7l2sp7exog7abkpyzmhttav2oku2uxm/1712";
    }
}
