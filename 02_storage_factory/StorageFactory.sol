// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Deploy simple storage
import {SimpleStorage} from "./SimpleStorage.sol";
// Importing specific file instead for everything take less gas
 


contract StorageFactory{

    SimpleStorage[] public listOfSimpleStoragesContracts;
    // address[] public listofSimpleStorageAddresses;

    function createSimpleStorageContract() public{
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfSimpleStoragesContracts.push(newSimpleStorage);
    }


    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public{
        // Need contract address and ABI (Application Binary Interface)
        // SimpleStorage simpleStorage = listOfSimpleStoragesContracts[_simpleStorageIndex];
        // simpleStorage.store(_newSimpleStorageNumber);

        // SimpleStorage simpleStorage = SimpleStorage(listofSimpleStorageAddresses[_simpleStorageIndex]);
        // simpleStorage.store(_newSimpleStorageNumber);

        listOfSimpleStoragesContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // SimpleStorage simpleStorage = listOfSimpleStoragesContracts[_simpleStorageIndex];
        // return simpleStorage.retrieve();

        return listOfSimpleStoragesContracts[_simpleStorageIndex].retrieve();
    }
}


// https://youtu.be/umepbfKp5rI?t=14285