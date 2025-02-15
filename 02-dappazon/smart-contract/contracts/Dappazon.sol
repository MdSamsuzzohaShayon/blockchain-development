// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// Till -> https://youtu.be/jcgfQEbptdo?t=19664

contract Dappazon {
    string public name;
    address public owner;

    struct Item {
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;
    }

    struct Order {
        uint256 time;
        Item item;
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256) public orderCount;
    mapping(address => mapping(uint256 => Order)) public orders;

    event List(string name, uint256 cost, uint256 quantity);
    event Buy(address buyer, uint256 orderId, uint256 itemId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is able to do this!");
        _;
    }
    constructor() {
        name = "Dappazon";
        owner = msg.sender; // Who deploy the smart contract
    }

    // List/add products
    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public onlyOwner {
        Item memory item = Item(
            _id,
            _name,
            _category,
            _image,
            _cost,
            _rating,
            _stock
        );

        items[_id] = item;
        emit List(_name, _cost, _stock);
    }

    // Buy products
    function buy(uint256 _id) public payable {
        Item memory item = items[_id];

        require(msg.value >= item.cost);
        require(item.stock > 0);

        Order memory order = Order(block.timestamp, item);
        orderCount[msg.sender]++;
        orders[msg.sender][orderCount[msg.sender]] = order;
        items[_id].stock = item.stock - 1;
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
    }

    // Withdraw funds
    function withdraw() public onlyOwner{
        (bool success, )= owner.call{value: address(this).balance}("");
        require(success);
    }
}
