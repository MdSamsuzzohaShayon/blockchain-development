// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 < 0.9.0;

contract SimpleStorage {
    // Defining types and variables 
    // uint unsigned integer
    // int signed integer 
    uint256 favoriteNumber = 5; // this is a integer of size 256 bits
    uint256 public defaultInit; // this will initilized as 0 by default
    bool favoriteBool = true; // this can be boolean value
    string favoriteString = "This is string";
    int256 favoriteInt = -5;
    address favoriteAddress = 0x459b23aE775b440eED6aE098926D5CFc1bBe80c8;
    bytes32 favoriteBytes = "cats";

    // First function 
    // State Variable Visibility - https://docs.soliditylang.org/en/v0.8.13/contracts.html#visibility-and-getters
    function store(uint256 _favoriteNum) public{
        defaultInit = _favoriteNum;
    }


    // Functions can be declared view in which case they promise not to modify the state. - https://docs.soliditylang.org/en/v0.8.13/contracts.html#view-functions
    function retrive() public view returns(uint256){
        return defaultInit;
    }

    // Functions can be declared pure in which case they promise not to read from or modify the state. In particular, it should be possible to evaluate a pure function at compile-time given only its inputs and msg.data, but without any knowledge of the current blockchain state. This means that reading from immutable variables can be a non-pure operation.
    function retrive2(uint256 _favoriteNum) public pure{
        _favoriteNum + _favoriteNum;
    }

    struct People{
        uint256 favNum;
        string favName;
    }


    //People public person = People({favNum: 2, favName: "Shayon"});
    People[] public people;

    // In variable declarations, do not separate the keyword mapping from its type by a space. Do not separate any nested mapping keyword from its type by whitespace.
    mapping(string => uint256) public nameToFavNum;

    // Each account has a data area called storage, which is persistent between function calls and transactions. Storage is a key-value store that maps 256-bit words to 256-bit words.
    // The second data area is called memory, of which a contract obtains a freshly cleared instance for each message call. Memory is linear and can be addressed at byte level, but reads are limited to a width of 256 bits, while writes can be either 8 bits or 256 bits wide. 
    // https://docs.soliditylang.org/en/v0.8.13/introduction-to-smart-contracts.html?highlight=memory#storage-memory-and-the-stack
    function addPerson(string memory _favName, uint256 _favNum) public{
        people.push(People(_favNum, _favName));
        nameToFavNum[_favName] = _favNum;
    }

}


// Tutorial Timeframe  01:30:50 - 02-09-00