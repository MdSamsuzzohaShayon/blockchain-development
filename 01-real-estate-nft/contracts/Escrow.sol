//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) external;
}

// Ownership is put in by neutral party and everybody else has to sign
contract Escrow {
    address public nftAddress;
    address public lender;
    address public inspector;
    address payable public seller;


    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender){
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }

    // Listing properties
    // Take the NFT out of the user's wallet and move it into escrow
    function list(uint256 _nftID) public{
        IERC721(nftAddress).transferFrom(/* seller */ msg.sender, /* This conmtract */ address(this), _nftID);
    }
}
