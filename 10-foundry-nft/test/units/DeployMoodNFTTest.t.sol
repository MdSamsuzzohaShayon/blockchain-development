// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";

contract DeployMoodNFTTest is Test {
    DeployMoodNFT public deployer;

    function setUp() public {
        deployer = new DeployMoodNFT();
    }

    function testConvertSvgToUri() public view {
        // base64 -i img/example-1.svg
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0iI2YwZjBmMCIvPjxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM0Q0FGNTAiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSI0Ii8+PHBvbHlnb24gcG9pbnRzPSIxMDAsNDAgMTIwLDgwIDE2MCw4MCAxMzAsMTEwIDE0MCwxNTAgMTAwLDEzMCA2MCwxNTAgNzAsMTEwIDQwLDgwIDgwLDgwIiBmaWxsPSIjRkY1NzIyIiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iMyIvPjx0ZXh0IHg9IjUwJSIgeT0iMTgwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMjAiIGZpbGw9IiMzMzMiPk15IE5GVDwvdGV4dD48L3N2Zz4=";
        // PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0iI2YwZjBmMCIvPjxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM0Q0FGNTAiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSI0Ii8+PHBvbHlnb24gcG9pbnRzPSIxMDAsNDAgMTIwLDgwIDE2MCw4MCAxMzAsMTEwIDE0MCwxNTAgMTAwLDEzMCA2MCwxNTAgNzAsMTEwIDQwLDgwIDgwLDgwIiBmaWxsPSIjRkY1NzIyIiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iMyIvPjx0ZXh0IHg9IjUwJSIgeT0iMTgwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMjAiIGZpbGw9IiMzMzMiPk15IE5GVDwvdGV4dD48L3N2Zz4=
        string memory svg =
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200"><rect width="100%" height="100%" fill="#f0f0f0"/><circle cx="100" cy="100" r="80" fill="#4CAF50" stroke="#333" stroke-width="4"/><polygon points="100,40 120,80 160,80 130,110 140,150 100,130 60,150 70,110 40,80 80,80" fill="#FF5722" stroke="#333" stroke-width="3"/><text x="50%" y="180" text-anchor="middle" font-family="Arial" font-size="20" fill="#333">My NFT</text></svg>';
        string memory actualUri = deployer.svgToImageURI(svg);
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }
}
