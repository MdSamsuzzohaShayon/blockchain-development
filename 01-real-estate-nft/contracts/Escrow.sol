//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) external;
}

contract Escrow {
    address public s_nftAddress;
    address public s_lender;
    address public s_inspector;
    address payable public s_seller;


    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender){
        s_nftAddress = _nftAddress;
        s_seller = _seller;
        s_inspector = _inspector;
        s_lender = _lender;
    }
}
