#!/bin/bash

# Initialize a new Foundry project with the necessary configuration and folder structure.
forge init

# Run all tests in the project to ensure everything is functioning correctly.
forge test

# Compile the Solidity contracts in the project.
forge compile

# Build the project, which includes compiling contracts and preparing artifacts.
forge build

# Run tests with verbose output to get more detailed information about the test execution.
forge test -vv

# Run a specific test named `testPriceFeedVersion` with even more detailed output.
forge test --match-test testPriceFeedVersion -vvv

# Execute the deployment script located at `script/DeployFundMe.s.sol`.
forge script script/DeployFundMe.s.sol

# Load environment variables from the `.env` file for use in subsequent commands.
source .env

# Run a specific test named `testPriceFeedVersion` with detailed output using the Sepolia network RPC URL.
forge test --match-test testPriceFeedVersion -vvv --fork-url $SEPOLIA_RPC_URL

# Run a specific test named `testPriceFeedVersion` with detailed output using the Sepolia network RPC URL.
forge test --match-test testPriceFeedVersion -vvv --rpc-url $SEPOLIA_RPC_URL

# Generate a coverage report using the Sepolia network RPC URL to check test coverage.
forge coverage --rpc-url $SEPOLIA_RPC_URL

# Run all tests using the Sepolia network RPC URL to test against a specific network.
forge test --rpc-url $SEPOLIA_RPC_URL

# Run all tests using the Mainnet network RPC URL to test against the main Ethereum network.
forge test --fork-url $MAINNET_RPC_URL

# Create a snapshot of the blockchain state after running tests named `testWithdrawFromMultipleFunders`.
forge snapshot --match-test testWithdrawFromMultipleFunders

# Run the Chisel tool for a detailed inspection of the Solidity code.
chisel

# Inspect the storage layout of the `FundMe` contract to see how storage is organized.
forge inspect FundMe storageLayout

# Execute the deployment script with specific RPC URL, private key, and broadcasting settings.
forge script script/DeployFundMe.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast

# Use the `cast` tool to query the storage of the contract at the given address and slot index 2.
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 2

# Use the `cast` tool to get the function signature of the `fund()` function.
cast sig "fund()"


# Makefile commands (shortcut)
# Build the project using Makefile.
make build

# Deploy the project using Makefile.
make deploy
