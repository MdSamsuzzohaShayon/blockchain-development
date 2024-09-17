// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

/**
 * Get funds from users (minimum 5 USD)
 * Withdraw funds to the owner of the contract
 * Set a minimum funding value in USD
 */

contract FundMe {
    using PriceConverter for uint256;

    uint256 public myVal = 1;
    uint256 public minUSD = 5e18;

    address[] public funders;
    /**
     * 04:59:00 - https://youtu.be/umepbfKp5rI?t=17958
     * https://docs.soliditylang.org/en/v0.8.7/types.html#mapping-types
     * Mapping Types
     * Mapping types use the syntax mapping(_KeyType => _ValueType) and variables of mapping type are declared using the syntax mapping(_KeyType => _ValueType) _VariableName.
     * The _KeyType can be any built-in value type, bytes, string, or any contract or enum type. Other user-defined or complex types, such as mappings, structs or array types are not allowed.
     * _ValueType can be any type, including mappings, arrays and structs.
     */
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

    /**
     * address payable: Same as address, but with the additional members transfer and send.
     * https://docs.soliditylang.org/en/v0.8.25/types.html#address
     * It is important to also provide the`payable` keyword here, otherwise the function will automatically reject all Ether sent to it.
     * It is often a good idea to use `require` to check if functions are called correctly.
     * Undo any actions that have been done, and the remaining gas back -> https://youtu.be/umepbfKp5rI?t=15516
     *
     * https://docs.soliditylang.org/en/develop/units-and-global-variables.html#block-and-transaction-properties
     * msg.value (uint): number of wei sent with the message
     * The values of all members of msg, including msg.sender and msg.value can change for every external function call. This includes calls to library functions.
     *
     * https://chain.link/education-hub/oracle-problem
     * The blockchain oracle problem refers to the inability of blockchains to access external data, making them isolated networks, akin to a computer with no Internet connection. Bridging the connection between the blockchain (onchain) and the outside world (offchain) requires an additional piece of infrastructure—an oracle.
     * Centralized Blockchain Oracles:
     *
     * https://chain.link/education/blockchain-oracles
     * Blockchain oracles are entities that connect blockchains to external systems, thereby enabling smart contracts to execute based upon inputs and outputs from the real world.
     *
     * https://docs.chain.link/data-feeds
     * Chainlink Data Feeds are the quickest way to connect your smart contracts to the real-world data such as asset prices, reserve balances, NFT floor prices, and L2 sequencer health.
     * https://data.chain.link/feeds
     * https://data.chain.link/feeds/ethereum/mainnet/eth-usd
     *
     * Operating a Chainlink node allows you to be part of the Chainlink Network, helping developers build hybrid smart contracts, giving them access to real-world data and services.
     * https://docs.chain.link/chainlink-nodes
     */

    /**
     * 05:24:00 https://youtu.be/umepbfKp5rI?t=19465
     * Only owner of the contract can withdraw the fund
     * 
     * A constructor is optional. Only one constructor is allowed, which means overloading is not supported.
     */

    address public owner;
    constructor() {
        owner = msg.sender;
    }

    // Recap- 4:36:22 https://youtu.be/umepbfKp5rI?t=16582
    // Set WEI value 10000000000000000 and send
    function fund() public payable {
        myVal = myVal + 2; // This line will be revarted if (msg.value > 1e18) is not true, therefore if it add 2 to myVal it will be revarted to previous value
        // require(msg.value > 1e18, "Didn't send enough ETH!");// 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        // msg.value willbe automitically passed to getConversionRate as first parameter
        require(
            msg.value.getConversionRate() > minUSD,
            "Didn't send enough ETH!"
        ); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18

        funders.push(msg.sender); // msg.sender (address): sender of the message (current call)
        addressToAmountFunded[msg.sender] += msg.value;
    }

    /**
     * Withdraw Contract
     * This contract allows funders to withdraw their funds.
     */
    function withdraw() public onlyOwner {

        // require(msg.sender == owner, "Must be owner");

        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // Reset funders
        funders = new address[](0);
        // withdraw
        /**
         * https://solidity-by-example.org/sending-ether/
         * There are 3 different ways to send native blockchain currencies
         * 1. Transfer: It transfers the contract's balance to the caller (the person who invoked the function).
         * 2. Send: An alternative way to send funds to the caller. It returns a boolean indicating whether the transfer was successful.
         * 3. Call: (Rocommended way) Another alternative way to send funds, using a low-level call. It also returns a boolean indicating success and allows sending additional data (though not used in this example).
         */

        // payable(msg.sender).transfer(address(this).balance); // msg.sender = payable address & payable(msg.sender) = payable address

        // bool sendSuccess = payable(msg.sender).send(address(this).balance); // msg.sender = payable address & payable(msg.sender) = payable address
        // require(sendSuccess, "Send Failed");

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        // Checks whether the transfer or call was successful. If not, it reverts the transaction with an error message.
        require(callSuccess, "Call Failed");
    }

    /**
     * Modifiers can be used to change the behavior of functions in a declarative way. For example, you can use a modifier to automatically check a condition prior to executing the function.
     * https://docs.soliditylang.org/en/latest/contracts.html#function-modifiers
     */
     modifier onlyOwner(){
        require(msg.sender == owner, "Owner is not sender!");
        _; // Rest of the code will run if test passed
     }

}

/**
 * Every transaction will have some attribute
 * Nonce: tx count for the account
 * Gas price: price per unit of gas (in wei)
 * Gas Limit: max gas that this tx can use
 * To: address that the tx is sent to
 * Value amount of wei to send
 * Data: what to send to the To address
 * v,r,s: components of tx signature
 */

// Recap: https://youtu.be/umepbfKp5rI?t=17993
