#!/bin/bash

forge init
forge build
forge fmt
forge test
forge test --mt testRaffleRevertWhenDoNotPayEnough
forge coverage