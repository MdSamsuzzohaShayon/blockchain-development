#!/bin/bash

# rm -rf ignition/deployments && npx hardhat ignition deploy ./ignition/modules/Dappazon.ts --network localhost
npx hardhat ignition deploy ./ignition/modules/Dappazon.ts --network localhost
# DappazonModule#Dappazon - 0x5FbDB2315678afecb367f032d93F642f64180aa3

npx hardhat console --network localhost
# > const Dappazon = await ethers.getContractAt("Dappazon", "0x5FbDB2315678afecb367f032d93F642f64180aa3");
# console.log(await Dappazon.name());
# console.log(await Dappazon.items(1));
# > .exit
