// SPDX-License_Identifier: MIT

pragma solidity >=0.6.0 < 0.9.0;

import "./01_simple_storage.sol";

contract StorageFactory is SimpleStorage{ // Inheritance
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public{
        // Creating an object
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIdx, uint256 _simpleStorageNum) public{
        // We need address and ABI (Application Binary Interface) to intract with contract 
        SimpleStorage(address(simpleStorageArray[_simpleStorageIdx])).store(_simpleStorageNum);
    }

    function sfGet(uint256 _simpleStorageIdx)public view returns(uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIdx])).retrive();
    }
}

// Tutorial Timeframe  02-09-00 - 