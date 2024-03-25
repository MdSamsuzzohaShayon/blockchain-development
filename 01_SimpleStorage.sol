// SPDX-License-Identifier: MIT
pragma solidity 0.8.19; // This is the version


contract SimpleStorage{
    /* Basic Types: booleab, unit, int, address, bytes, string
     * All variables has a default value
     * uint256 = 0
     * https://docs.soliditylang.org/en/v0.8.25/types.html
     */
    /*
     * bool hasFavoriteNumber = true;
     * uint256 favoriteNumber = 88;
     * int256 favoriteInt = -88;
     * address myAddress = 0xBB95e2b95Fc02d460c352FB51365bfAB61FB7899;
     * string favoriteNumberInText = "eighty-eight";
     * bytes32 favoriteBytes32 = "cat";
    */

    uint256 public myFavoriteNumber;

    /**
     *
     * Arrays can have a compile-time fixed size, or they can have a dynamic size.
     * https://docs.soliditylang.org/en/latest/types.html#arrays
     * 
     */
    // uint256[] listOfFavoriteNumbers;

    /**
     * Mapping - https://docs.soliditylang.org/en/v0.8.7/types.html#mapping-types
     * 
     */
    mapping(string => uint256) public nameToFavoriteNumber;

    /**
     * Solidity provides a way to define new types in the form of structs
     * https://docs.soliditylang.org/en/latest/types.html#structs
     */
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // Person public neymar = Person(10, "Neymar");
    Person[] public listOfPeople;

    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        /**
         * view for functions: Disallows modification of state.
         * https://docs.soliditylang.org/en/v0.8.25/cheatsheet.html#modifiers
         * pure for functions: Disallows modification or access of state.
         */
         return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    /**
     * Data storing in Solidity
     * 1. Stack
     * 2. Memory - temporary variable. It is accessable only once
     * 3. Storage - It is permanent variable that can not be modified
     * 4. Calldata - Memory can be changed but call data is not
     * 5. Code
     * 6. Logs
     */
}


// https://youtu.be/umepbfKp5rI?t=8122