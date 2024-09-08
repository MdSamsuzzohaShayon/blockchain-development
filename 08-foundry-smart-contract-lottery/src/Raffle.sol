// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title A simple Raffle Contract
 * @author Md Shayon
 * @notice This contract is for creating a simple raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle{
    error Raffle__NotEnoughEthSent();
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    // Events
    /**
     * https://docs.soliditylang.org/en/latest/contracts.html#events
     * Solidity events give an abstraction on top of the EVM’s logging functionality. 
     * Applications can subscribe and listen to these events through the RPC interface of an Ethereum client.
     */
    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee){
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable{
        // require(msg.value < i_entranceFee, "Not enough ETH sent!);
        if (msg.value < i_entranceFee){
            revert Raffle__NotEnoughEthSent();
        }
        // Events make migration easier and it makes front end "indexing" easier
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public{}

    // Getters
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }
}

/**
 * Order of Layout - https://docs.soliditylang.org/en/latest/style-guide.html#order-of-layout
 */