#!/bin/bash

# Initializes a new Foundry project in the current directory.
forge init

# Compiles the smart contracts in the project.
forge build

# Automatically formats the Solidity files in the project.
forge fmt

# Runs all the test files in the project.
forge test

# Runs a specific test case (in this example, "testRaffleRevertWhenDoNotPayEnough").
forge test --mt testRaffleRevertWhenDoNotPayEnough

# Measures test coverage for the entire project.
forge coverage

# Gets the function signature for the Solidity function "createSubscription()".
cast sig "createSubscription()"

# Formats the Solidity files again.
forge fmt

# Loads environment variables from the .env file.
source .env

# Imports a wallet interactively (e.g., using a private key) and labels it as "myaccount".
cast wallet import myaccount --interactive

# Runs the specified Foundry script to fund a subscription using the Sepolia testnet and the "myaccount" wallet.
forge script script/Interactions.s.sol:FundSubscription --rpc-url $SEPOLIA_RPC_URL --account myaccount --broadcast

# Runs a specific test with verbose output (-vvvv) to debug a particular test (in this case, "testDoNotAllowPlayersToEnterWhileRaffleIsCalculating").
forge test --mt testDoNotAllowPlayersToEnterWhileRaffleIsCalculating -vvvv

# Generates a detailed coverage report and outputs it to a file (coverage.txt).
forge coverage --report debug > coverage.txt

# Runs a specific test case with increased verbosity (-vvv) to debug the test "testFulfillRandomWordsCanOnlyBeCalledAfterPerformUpkeep".
forge test --match-test testFulfillRandomWordsCanOnlyBeCalledAfterPerformUpkeep -vvv

# Runs tests using a forked version of the Sepolia testnet.
forge test --fork-url $SEPOLIA_RPC_URL

# Moves the keystore file for "myaccount" to a backup location for safekeeping.
mv /home/shayon/.foundry/keystores/myaccount /home/shayon/.foundry/keystores/myaccount.backup

# Re-imports the wallet using the provided private key and labels it "myaccount".
cast wallet import --private-key $PRIVATE_KEY myaccount

# Lists all the wallets currently imported into Foundry.
cast wallet list

# Uses a private key to perform actions with a specific account (e.g., sending transactions).
cast wallet --private-key <PRIVATE_KEY_OF_AN_ACCOUNT>

# Verifies a deployed contract's code on Etherscan, specifying the contract source, the API key, the network's RPC URL, and showing the standard JSON input.
forge verify-contract <DEPLOYED_AND_VERIFIED_CONTRACT_ADDRESS> src/Raffle.sol:Raffle --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $SEPOLIA_RPC_URL --show-standard-json-input

# Debugs the test "testFulfillRandomWordsPickAWinnerResetsAndSendsMoney" with enhanced logging.
forge test --debug testFulfillRandomWordsPickAWinnerResetsAndSendsMoney
