#!/bin/bash

# https://github.com/foundry-rs/forge-std
forge install foundry-rs/forge-std@v1.9.2 --no-commit


# https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/vrf/VRFCoordinatorV2.sol
# https://github.com/smartcontractkit/chainlink-brownie-contracts
# forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
git clone https://github.com/smartcontractkit/chainlink-brownie-contracts.git lib/chainlink-brownie-contracts

# https://github.com/transmissions11/solmate
forge install transmissions11/solmate --no-commit

# https://github.com/Cyfrin/foundry-devops?tab=readme-ov-file#installation
forge install Cyfrin/foundry-devops --no-commit