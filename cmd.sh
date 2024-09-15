#!/bin/bash

npm i hardhat
npx hardhat init
npm create vite@latest
npx hardhat node
# https://hardhat.org/hardhat-runner/docs/guides/deploying
npx hardhat ignition deploy ./ignition/modules/UploadModule.ts --network localhost