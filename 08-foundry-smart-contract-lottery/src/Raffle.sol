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
    error Raffle__TransferFailed();
    error Raffle__NotOpen();
    error Raffle__UpkeepNotNeeded(uint256 balance, uint256 playersLength, uint256 raffleState);

    // Type Decorations - https://solidity-by-example.org/enum/
    enum RaffleState{
        OPEN,
        CALCULATING
    }


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
    address payable s_recentWinner;

    RaffleState private s_raffleState;

    // Event declaration to log when a player enters the raffle
    /**
     * @dev Events are emitted to allow off-chain applications to track changes and
     * interact with smart contracts. They facilitate logging and listening to contract activity.
     * More info: https://docs.soliditylang.org/en/latest/contracts.html#events
     */
    event EnteredRaffle(address indexed player);
    event WinnerPicked(address indexed winner);

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
        i_keyHash = gasLene; // Set the key hash for the VRF request
        i_subscriptionId = subscriptionId; // Store the subscription ID for Chainlink VRF
        i_callbackGasLimit = callbackGasLimit; // Set the gas limit for the VRF callback

        s_lastTimeStamp = block.timestamp; // Initialize the last timestamp as the contract deployment time
        s_raffleState = RaffleState.OPEN;
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
        if(s_raffleState != RaffleState.OPEN){
            revert Raffle__NotOpen();
        }
        s_players.push(payable(msg.sender)); // Add the player to the raffle participants
        emit EnteredRaffle(msg.sender); // Emit an event for off-chain tracking
    }

    /**
     * Use these elements to create a compatible contract that will automatically increment a counter after every updateInterval seconds. 
     * After you register the contract as an upkeep, the Chainlink Automation Network frequently simulates your checkUpkeep offchain to determine 
     * if the updateInterval time has passed since the last increment (timestamp). When checkUpkeep returns true, the Chainlink Automation Network 
     * calls performUpkeep onchain and increments the counter. This cycle repeats until the upkeep is cancelled or runs out of funding.
     * Reference: https://docs.chain.link/chainlink-automation/guides/compatible-contracts#example-automation-compatible-contract-using-custom-logic-trigger
     * 
     * @dev This is the function thaty the chainlink nodes will call to see if the following should be true in order dor upkeepNeeded to be true:
     * 1. The time interval has passed between raffle runs
     * 2. The lottery is open
     * 3. The contract has ETH (has players)
     * 4. Implicitly your subscription has LINK
     */
     function checkUpkeep(bytes memory /* checkdata */) public view returns(bool upkeepNeeded, bytes memory /* performData */ ){
        bool timeHasPassed = (block.timestamp - s_lastTimeStamp) >= i_interval;
        bool isOpen = s_raffleState == RaffleState.OPEN;
        bool hasBalance = address(this).balance > 0;
        bool hasPlayers = s_players.length > 0;
        upkeepNeeded = timeHasPassed && isOpen && hasBalance && hasPlayers;
        return (upkeepNeeded, "0x0"); // 0x0, "", hex"" all three returns means null
     }

    /**
     * @dev External function to trigger the random winner selection process.
     * Ensures that the raffle interval has passed before proceeding.
     * Utilizes Chainlink VRF to request a random number.
     * Reference: https://docs.chain.link/chainlink-automation/guides/compatible-contracts#example-automation-compatible-contract-using-custom-logic-trigger
     */
    function performUpkeep(bytes calldata /* performData */) external {
        (bool upkeepNeeded, ) = checkUpkeep("");
        if(!upkeepNeeded){
            revert Raffle__UpkeepNotNeeded(address(this).balance, s_players.length, uint256(s_raffleState));
        }
        s_raffleState = RaffleState.CALCULATING;

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
        s_vrfCoordinator.requestRandomWords(request);
    }

    /**
     * @dev Internal function to fulfill randomness requests once the VRF provides random values.
     * This function is called automatically by the Chainlink VRF system.
     *
     * The Checks-Effects-Interactions pattern ensures that all code paths through a contract complete 
     * all required checks of the supplied parameters before modifying the contract’s state (Checks); 
     * https://docs.soliditylang.org/en/latest/security-considerations.html#reentrancy
     * 
     */
    function fulfillRandomWords(
        uint256 /*requestId*/,
        uint256[] calldata randomWords
    ) internal override {
        // Implementation logic to use the random number(s) for selecting a raffle winner will go here.
        uint256 winnerIndex = randomWords[0] % s_players.length;
        address payable recentWinner = s_players[winnerIndex];
        s_recentWinner = recentWinner;
        
        s_raffleState = RaffleState.OPEN;
        s_players = new address payable[](0);
        s_lastTimeStamp = block.timestamp;
        emit WinnerPicked(s_recentWinner);

        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        if(!success){
            revert Raffle__TransferFailed();
        }

    }

    /**
     * @dev Getter function to retrieve the entrance fee for the raffle.
     * @return The entrance fee as a uint256 value.
     */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee; // Return the entrance fee to the caller
    }

    function getRaffleState() external view returns(RaffleState){
        return s_raffleState;
    }

    function getPlayer(uint256 indexOfPlayer) external view returns(address){
        return s_players[indexOfPlayer];
    }
}

/**
 * @notice Solidity contracts follow a specific layout order as per the style guide:
 * https://docs.soliditylang.org/en/latest/style-guide.html#order-of-layout
 */

 /**
  * Getting Started with Chainlink Automation - https://docs.chain.link/chainlink-automation/overview/getting-started
  * Register new upkeephttps://automation.chain.link/
  * Example Automation-compatible contract using custom logic trigger - https://docs.chain.link/chainlink-automation/guides/compatible-contracts
  */
