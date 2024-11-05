#!/bin/bash

forge install foundry-rs/forge-std
forge install openzeppelin/openzeppelin-contracts --no-commit
git clone https://github.com/smartcontractkit/chainlink-brownie-contracts.git lib/chainlink-brownie-contracts