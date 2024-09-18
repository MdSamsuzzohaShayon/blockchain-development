#!/bin/bash

forge init
forge build
forge fmt
forge test
forge test --mt testRaffleRevertWhenDoNotPayEnough
forge coverage
cast sig "createSubscription()"
forge fmt

source .env
cast wallet import myaccount --interactive
forge script script/Interactions.s.sol:FundSubscription --rpc-url $SEPOLIA_RPC_URL --account myaccount --broadcast
forge test --mt testDoNotAllowPlayersToEnterWhileRaffleIsCalculating -vvvv
forge coverage --report debug > coverage.txt
forge test --match-test testFulfillRandomWordsCanOnlyBeCalledAfterPerformUpkeep -vvv
forge test --fork-url $SEPOLIA_RPC_URL

mv /home/shayon/.foundry/keystores/myaccount /home/shayon/.foundry/keystores/myaccount.backup
cast wallet import --private-key $PRIVATE_KEY myaccount
cast wallet list
cast wallet --private-key <PRIVATE_KEY_OF_AN_ACCOUNT>

# Get the deployed contract address  verified in etherscan
forge verify-contract <DEPLOYED_AND_VERIFIED_CONTRACT_ADDRESS> src/Raffle.sol:Raffle --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $SEPOLIA_RPC_URL --show-standard-json-input
forge test --debug testFulfillRandomWordsPickAWinnerResetsAndSendsMoney