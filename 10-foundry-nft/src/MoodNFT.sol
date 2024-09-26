// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * We can change the mood of NFT
 * If the face is happy we can make them sad, if they are sad we can make them happy
 */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNFT is ERC721{
    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

    constructor(string memory happySvg, string memory sadSvg) ERC721("Mood NFT", "MN"){
        s_tokenCounter = 0;
        s_sadSvg = sadSvg;
        s_happySvg = happySvg;
    }

    function mintNft() public{
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    
}