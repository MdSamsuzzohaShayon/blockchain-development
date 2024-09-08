// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 * @title A simple Raffle Contract
 * @author Md Shayon
 * @notice This contract is for creating a simple raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle is VRFConsumerBaseV2Plus {
    error Raffle__NotEnoughEthSent();
    // State variables

    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    // address private immutable i_vrfCoordinator;
    bytes32 private immutable i_keyHash;
    uint256 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    // Events
    /**
     * https://docs.soliditylang.org/en/latest/contracts.html#events
     * Solidity events give an abstraction on top of the EVM’s logging functionality.
     * Applications can subscribe and listen to these events through the RPC interface of an Ethereum client.
     */
    event EnteredRaffle(address indexed player);

    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLene,
        uint256 subscriptionId,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2Plus(vrfCoordinator) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        // Superclass has s_vrfCoordinator variable so we do not need to create it again in this class
        i_keyHash = gasLene;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
    }

    function enterRaffle() external payable {
        // require(msg.value < i_entranceFee, "Not enough ETH sent!);
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        // Events make migration easier and it makes front end "indexing" easier
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        /**
         * TODO:
         *      Get a random number
         *      Use the random number to pick a player
         *      Be automatically called
         */

        // Check enough time has passed
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }

        // https://docs.chain.link/vrf/v2-5/overview/subscription
        // https://docs.chain.link/vrf/v2-5/subscription/get-a-random-number#overview
        // https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/vrf/VRFCoordinatorV2.sol
        // https://youtu.be/-1GB6m39-rM?t=53918

        // Will revert if subscription is not set and funded.
        // lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol
        // https://docs.chain.link/vrf/v2-5/getting-started#contract-variables
        VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient
            .RandomWordsRequest({
                keyHash: i_keyHash,
                subId: i_subscriptionId,
                requestConfirmations: REQUEST_CONFIRMATIONS,
                callbackGasLimit: i_callbackGasLimit,
                numWords: NUM_WORDS,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        nativePayment: false
                    })
                )
            });

        // lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] calldata randomWords
    ) internal override {}

    // Getters
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}

/**
 * Order of Layout - https://docs.soliditylang.org/en/latest/style-guide.html#order-of-layout
 */
