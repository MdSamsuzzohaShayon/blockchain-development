// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * We can change the mood of NFT
 * If the face is happy we can make them sad, if they are sad we can make them happy
 */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 private s_tokenCounter;
    string private s_sadSvgImgUri;
    string private s_happySvgImgUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happySvgImgUri,
        string memory sadSvgImgUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImgUri = happySvgImgUri;
        s_happySvgImgUri = sadSvgImgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json:base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImgUri;
        } else {
            imageURI = s_sadSvgImgUri;
        }
        // Create metadata Object - https://docs.openzeppelin.com/contracts/4.x/utilities#base64
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that reflectys owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            ); // {"name": "Mood NFT"}
    }
}
