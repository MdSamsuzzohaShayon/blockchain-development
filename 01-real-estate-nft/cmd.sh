#/bin/bash

npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost