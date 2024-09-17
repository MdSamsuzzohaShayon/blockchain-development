// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Import Chainlink VRF v2 Plus contracts for generating random numbers securely.
// VRFConsumerBaseV2Plus provides the functionality to use Chainlink's randomness service.
// VRFV2PlusClient includes utilities to make randomness requests.
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 * @title Raffle Contract
 * @author Md Shayon
 * @notice This contract manages a raffle system where participants are randomly selected as winners.
 * @dev It leverages Chainlink VRF v2 for secure and verifiable randomness.
 */
contract Raffle is VRFConsumerBaseV2Plus {
    // Custom errors are defined to optimize gas usage by providing specific error reasons.
    error Raffle__NotEnoughEthSent(); // Triggered when a participant sends insufficient ETH.
    error Raffle__TransferFailed(); // Triggered if the transfer to the winner fails.
    error Raffle__NotOpen(); // Triggered if an attempt is made to enter a raffle that isn't open.
    error Raffle__UpkeepNotNeeded(
        uint256 balance,
        uint256 playersLength,
        uint256 raffleState
    ); // Triggered when upkeep conditions are not met.

    // Enumeration to represent the states of the raffle.
    enum RaffleState {
        OPEN, // Indicates the raffle is open for participation.
        CALCULATING // Indicates that the raffle is in the process of selecting a winner.
    }

    // Chainlink VRF configuration constants to ensure randomness requests are handled correctly.
    uint16 private constant REQUEST_CONFIRMATIONS = 3; // Number of confirmations required before the randomness request is fulfilled.
    uint32 private constant NUM_WORDS = 1; // Number of random numbers requested from Chainlink VRF.

    // Immutable variables for VRF configuration and raffle settings, ensuring they cannot be modified after contract deployment.
    bytes32 private immutable i_keyHash; // Used to specify the VRF key hash for randomness requests.
    uint256 private immutable i_subscriptionId; // Chainlink VRF subscription ID to manage VRF requests.
    uint32 private immutable i_callbackGasLimit; // Gas limit set for the callback function execution.

    uint256 private immutable i_entranceFee; // The required ETH amount to enter the raffle.
    uint256 private immutable i_interval; // Time duration between each raffle draw.
    address payable[] private s_players; // Array storing addresses of participants.
    uint256 private s_lastTimeStamp; // Tracks the last time a winner was selected.
    address payable s_recentWinner; // Stores the address of the most recent winner.

    RaffleState private s_raffleState; // Tracks the current state of the raffle.

    // Events are used to log important actions such as a player entering the raffle or a winner being picked.
    /**
     * @dev Emits when a player successfully enters the raffle.
     */
    event EnteredRaffle(address indexed player);

    /**
     * @dev Emits when a winner is selected and rewarded.
     */
    event WinnerPicked(address indexed winner);
    event RequestRaffleWinner(uint256 indexed requestId);

    /**
     * @dev Constructor to set up initial raffle settings and Chainlink VRF parameters.
     * @param entranceFee Amount of ETH required to enter the raffle.
     * @param interval Time between raffle draws.
     * @param vrfCoordinator Address of Chainlink VRF Coordinator.
     * @param gasLene Key hash used for randomness requests.
     * @param subscriptionId Chainlink VRF subscription ID.
     * @param callbackGasLimit Gas limit for the VRF callback function.
     */
    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLene,
        uint256 subscriptionId,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2Plus(vrfCoordinator) {
        i_entranceFee = entranceFee; // Set the entrance fee required to participate in the raffle.
        i_interval = interval; // Define the interval between each raffle draw.
        i_keyHash = gasLene; // Set the key hash for Chainlink VRF to request randomness.
        i_subscriptionId = subscriptionId; // Store the subscription ID for managing VRF requests.
        i_callbackGasLimit = callbackGasLimit; // Define the maximum gas that can be used by the callback function.

        s_lastTimeStamp = block.timestamp; // Initialize the timestamp to the current block time.
        s_raffleState = RaffleState.OPEN; // Set the initial state of the raffle to OPEN.
    }

    /**
     * @dev Allows users to enter the raffle by sending the required ETH.
     * @notice Reverts if the ETH sent is less than the required entrance fee.
     * @dev Emits the `EnteredRaffle` event for tracking entries.
     */
    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent(); // Revert transaction if not enough ETH is sent.
        }
        if (s_raffleState != RaffleState.OPEN) {
            revert Raffle__NotOpen(); // Revert transaction if the raffle is not open.
        }
        s_players.push(payable(msg.sender)); // Add the sender to the list of participants.
        emit EnteredRaffle(msg.sender); // Log the entry of a new player.
    }

    /**
     * Checks if the conditions are met for performing upkeep, such as time elapsed, raffle state, and player balance.
     * Checkdata Additional data for the upkeep check (not used here).
     * @return upkeepNeeded Whether upkeep is required based on the conditions.
     * @return performData Data to be used in the `performUpkeep` function (not used here).
     */
    function checkUpkeep(
        bytes memory /* checkdata */
    ) public view returns (bool upkeepNeeded, bytes memory /* performData */) {
        bool timeHasPassed = (block.timestamp - s_lastTimeStamp) >= i_interval;
        bool isOpen = s_raffleState == RaffleState.OPEN;
        bool hasBalance = address(this).balance > 0;
        bool hasPlayers = s_players.length > 0;
        upkeepNeeded = timeHasPassed && isOpen && hasBalance && hasPlayers;
        return (upkeepNeeded, "0x0"); // 0x0 indicates null data for performUpkeep.
    }

    /**
     * @dev Initiates the process of selecting a winner when upkeep conditions are met.
     * @notice Ensures that the raffle interval has passed and then requests a random number from Chainlink VRF.
     * @dev Handles VRF request and sets the raffle state to CALCULATING.
     */
    function performUpkeep(bytes calldata /* performData */) external {
        (bool upkeepNeeded, ) = checkUpkeep("");
        if (!upkeepNeeded) {
            revert Raffle__UpkeepNotNeeded(
                address(this).balance,
                s_players.length,
                uint256(s_raffleState)
            );
        }
        s_raffleState = RaffleState.CALCULATING; // Change state to CALCULATING while selecting a winner.

        // Create a request for random words from Chainlink VRF to ensure a fair winner selection.
        VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient
            .RandomWordsRequest({
                keyHash: i_keyHash, // Specify the key hash for the VRF request.
                subId: i_subscriptionId, // Provide the subscription ID for managing VRF requests.
                requestConfirmations: REQUEST_CONFIRMATIONS, // Number of confirmations to wait for before fulfilling the request.
                callbackGasLimit: i_callbackGasLimit, // Set the gas limit for the callback function.
                numWords: NUM_WORDS, // Number of random words requested.
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        nativePayment: false // Use LINK tokens for payment rather than native ETH.
                    })
                )
            });

        // Request random words from Chainlink VRF to determine the raffle winner.
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
        emit RequestRaffleWinner(requestId);
    }

    /**
     * @dev Handles the callback from Chainlink VRF with the random words to select the winner.
     * @param randomWords Array of random numbers provided by Chainlink VRF.
     * @notice Updates the raffle state and handles winner payout.
     * @dev Follows the Checks-Effects-Interactions pattern to ensure secure state changes and interactions.
     */
    function fulfillRandomWords(
        uint256,
        /*requestId*/ uint256[] calldata randomWords
    ) internal override {
        uint256 winnerIndex = randomWords[0] % s_players.length; // Select a winner based on the random number.
        address payable recentWinner = s_players[winnerIndex]; // Identify the winner.
        s_recentWinner = recentWinner; // Store the winner's address.

        s_raffleState = RaffleState.OPEN; // Reset raffle state to OPEN for new entries.
        s_players = new address payable[](0); // Clear the list of participants.
        s_lastTimeStamp = block.timestamp; // Update the timestamp to the current block time.
        emit WinnerPicked(s_recentWinner); // Log the winner selection.

        // Transfer the raffle prize to the winner.
        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        if (!success) {
            revert Raffle__TransferFailed(); // Revert transaction if the transfer fails.
        }
    }

    /**
     * @dev Returns the entrance fee required to participate in the raffle.
     * @return The entrance fee amount in wei.
     */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee; // Return the entrance fee.
    }

    /**
     * @dev Returns the address of the most recent raffle winner.
     * @return The address of the recent winner.
     */
    function getRecentWinner() external view returns (address) {
        return s_recentWinner; // Return the address of the most recent winner.
    }

    /**
     * @dev Returns the current state of the raffle.
     * @return The current raffle state (OPEN or CALCULATING).
     */
    function getRaffleState() external view returns (RaffleState) {
        return s_raffleState; // Return the current state of the raffle.
    }

    /**
     * @dev Returns the timestamp of the last raffle draw.
     * @return The timestamp of the last winner selection.
     */
    function getLastTimeStamp() external view returns (uint256) {
        return s_lastTimeStamp; // Return the timestamp of the last draw.
    }

    /**
     * @dev Returns the list of participants in the current raffle.
     * @return Array of addresses of participants.
     */
    function getPlayers() external view returns (address payable[] memory) {
        return s_players; // Return the list of participants.
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
