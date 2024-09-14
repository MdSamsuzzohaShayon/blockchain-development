// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/*
 * 01:02:40 - https://youtu.be/jcgfQEbptdo?t=3765
 * 
 * Concept:
 *      How to pay with crypto currency, usually with ether?
 *      How to use modifiers?
 *      How to use visibility?
 *      How to use events?
 *      How to use enums?
 */
 
error HotelRoom__AlreadyBookedTheRoom();
error HotelRoom__NotEnoughEth();

contract HotelRoom {

    enum RoomStatus{
        VACANT,
        OCCUPIED
    }

    RoomStatus public currentStatus;
    address payable public s_owner; // Creator of the smart contract

    event Occupy(address occupant, uint256 value);

    constructor(){
        s_owner = payable(msg.sender);
        currentStatus = RoomStatus.VACANT;
    }

    modifier onlyWhileVacant{
        if(currentStatus == RoomStatus.OCCUPIED){
            revert HotelRoom__AlreadyBookedTheRoom();
        }
        _;
    }

    modifier onlyCostBearer(uint256 amount){
        if(msg.value < 2 ether){
            revert HotelRoom__NotEnoughEth();
        }
        _;
    }

    function book() public payable onlyWhileVacant onlyCostBearer(2 ether){
        
        
        currentStatus = RoomStatus.OCCUPIED;
        // Pay the person who created the smart contract
        s_owner.transfer(msg.value);
        (bool sent, bytes memory data) = s_owner.call{value: msg.value}("");
        require(true);
        emit Occupy(msg.sender, msg.value);
    }
}