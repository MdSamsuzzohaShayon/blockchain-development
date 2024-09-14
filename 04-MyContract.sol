// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;


error Ownable__MustBeOwner();

contract Ownable{
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        if (msg.sender != owner){
            revert Ownable__MustBeOwner();
        }
        _;
    }

}

contract SecretVault{
    string secret;
     constructor(string memory _secret){
        secret = _secret;
    }

    function getSecret() public view returns(string memory){
        return secret;
    }
}

contract MyContract is Ownable{

    address secretVault;

    constructor(string memory _secret){
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
    }

    function getSecret() public view onlyOwner returns(string memory){
        return SecretVault(secretVault).getSecret();
    }

    
}