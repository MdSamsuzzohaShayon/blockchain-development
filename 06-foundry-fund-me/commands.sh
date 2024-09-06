#!/bin/bash

forge init
forge test
forge compile
forge build
forge test -vv
forge test --match-test testPriceFeedVersion -vvv
forge script script/DeployFundMe.s.sol
source .env
forge test --match-test testPriceFeedVersion -vvv --fork-url $SEPOLIA_RPC_URL
forge test --match-test testPriceFeedVersion -vvv --rpc-url $SEPOLIA_RPC_URL
forge coverage --rpc-url $SEPOLIA_RPC_URL
forge test --rpc-url $SEPOLIA_RPC_URL
forge test --fork-url $MAINNET_RPC_URL
forge snapshot --match-test testWithdrawFromMultipleFunders
chisel
forge inspect FundMe storageLayout
forge script script/DeployFundMe.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 2
