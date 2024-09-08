// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Import Chainlink VRF v2 Plus contracts for randomness generation.
// VRFConsumerBaseV2Plus is used for inheriting VRF-related functionalities.
// VRFV2PlusClient is used for making random number requests.
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 * @title A simple Raffle Contract
 * @author Md Shayon
 * @notice This contract is used for creating a raffle system that randomly picks a winner.
 * @dev The contract utilizes Chainlink VRF v2 for secure randomness generation. 
 */
contract Raffle is VRFConsumerBaseV2Plus {

    // Custom error to revert the transaction if insufficient ETH is sent by the user
    error Raffle__NotEnoughEthSent();

    // Constant variables for Chainlink VRF configuration
    uint16 private constant REQUEST_CONFIRMATIONS = 3; // Number of confirmations before fulfilling randomness request
    uint32 private constant NUM_WORDS = 1; // Number of random words requested

    // Immutable state variables for VRF and raffle configuration
    bytes32 private immutable i_keyHash; // The key hash for randomness requests
    uint256 private immutable i_subscriptionId; // Chainlink VRF subscription ID
    uint32 private immutable i_callbackGasLimit; // Gas limit for the callback function

    uint256 private immutable i_entranceFee; // Fee required to enter the raffle
    uint256 private immutable i_interval; // Time interval for selecting a winner
    address payable[] private s_players; // Dynamic array of players in the raffle
    uint256 private s_lastTimeStamp; // Last timestamp when a winner was picked

    // Event declaration to log when a player enters the raffle
    /**
     * @dev Events are emitted to allow off-chain applications to track changes and
     * interact with smart contracts. They facilitate logging and listening to contract activity.
     * More info: https://docs.soliditylang.org/en/latest/contracts.html#events
     */
    event EnteredRaffle(address indexed player);

    /**
     * @dev Constructor to initialize the raffle and VRF-related configurations.
     * @param entranceFee The minimum amount of ETH required to enter the raffle.
     * @param interval The time duration between raffle draws.
     * @param vrfCoordinator Address of the Chainlink VRF Coordinator.
     * @param gasLene Key hash for randomness requests (used to determine the gas lane).
     * @param subscriptionId Chainlink VRF subscription ID.
     * @param callbackGasLimit Maximum gas that can be used in the callback function.
     */
    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLene,
        uint256 subscriptionId,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2Plus(vrfCoordinator) {
        i_entranceFee = entranceFee; // Initialize entrance fee for the raffle
        i_interval = interval; // Set the interval for picking a winner
        s_lastTimeStamp = block.timestamp; // Initialize the last timestamp as the contract deployment time
        i_keyHash = gasLene; // Set the key hash for the VRF request
        i_subscriptionId = subscriptionId; // Store the subscription ID for Chainlink VRF
        i_callbackGasLimit = callbackGasLimit; // Set the gas limit for the VRF callback
    }

    /**
     * @dev External function to allow users to enter the raffle by sending the required ETH.
     * Reverts if the sent ETH is less than the entrance fee.
     * Emits the `EnteredRaffle` event when a user enters the raffle.
     */
    function enterRaffle() external payable {
        // Check if the player has sent enough ETH, revert if not
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent(); // Custom error to save gas
        }
        s_players.push(payable(msg.sender)); // Add the player to the raffle participants
        emit EnteredRaffle(msg.sender); // Emit an event for off-chain tracking
    }

    /**
     * @dev External function to trigger the random winner selection process.
     * Ensures that the raffle interval has passed before proceeding.
     * Utilizes Chainlink VRF to request a random number.
     */
    function pickWinner() external {
        // Ensure the time interval has passed before picking a winner
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert(); // Revert if not enough time has passed
        }

        // Chainlink VRF documentation:
        // https://docs.chain.link/vrf/v2-5/overview/subscription
        // Documentation on getting a random number:
        // https://docs.chain.link/vrf/v2-5/subscription/get-a-random-number#overview
        // VRFCoordinatorV2.sol reference:
        // https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/vrf/VRFCoordinatorV2.sol
        // Video explanation: https://youtu.be/-1GB6m39-rM?t=53918

        // Create a VRFV2PlusClient request for randomness
        // Documentation on contract variables:
        // https://docs.chain.link/vrf/v2-5/getting-started#contract-variables
        VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient
            .RandomWordsRequest({
                keyHash: i_keyHash, // Pass the key hash
                subId: i_subscriptionId, // Pass the subscription ID
                requestConfirmations: REQUEST_CONFIRMATIONS, // Number of confirmations to wait
                callbackGasLimit: i_callbackGasLimit, // Gas limit for the callback
                numWords: NUM_WORDS, // Number of random words to request
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        nativePayment: false // Specify payment type (false for LINK payments)
                    })
                )
            });

        // Request random words from Chainlink VRF via the inherited s_vrfCoordinator
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
    }

    /**
     * @dev Internal function to fulfill randomness requests once the VRF provides random values.
     * This function is called automatically by the Chainlink VRF system.
     * @param requestId The ID of the request (not used in this case).
     * @param randomWords The random number(s) generated by Chainlink VRF.
     */
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] calldata randomWords
    ) internal override {
        // Implementation logic to use the random number(s) for selecting a raffle winner will go here.
    }

    /**
     * @dev Getter function to retrieve the entrance fee for the raffle.
     * @return The entrance fee as a uint256 value.
     */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee; // Return the entrance fee to the caller
    }
}

/**
 * @notice Solidity contracts follow a specific layout order as per the style guide:
 * https://docs.soliditylang.org/en/latest/style-guide.html#order-of-layout
 */
