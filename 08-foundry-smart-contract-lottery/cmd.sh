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