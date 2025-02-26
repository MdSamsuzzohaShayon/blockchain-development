// Deploying with hardhat scripts -> https://hardhat.org/ignition/docs/guides/scripts
// Deploying your contracts, hardhat ignition -> https://hardhat.org/hardhat-runner/docs/guides/deploying

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import itemsData from "../../items.json";
import { ethers } from "hardhat"; // Import ethers for conversion

const DappazonModule = buildModule("DappazonModule", (m) => {
  // Define deployer account (first account from Hardhat)
  const deployer = m.getAccount(0);

  // Deploy contract using deployer account
  const dappazon = m.contract("Dappazon", [], { from: deployer });

  // Seed contract with items, ensuring deployer lists them
  itemsData.items.forEach((item, index) => {
    m.call(
      dappazon,
      "list",
      [
        item.id,
        item.name,
        item.category,
        item.image,
        ethers.parseUnits(item.price, "ether"), // ✅ Convert price from ETH to Wei
        item.rating,
        item.stock,
      ],
      {
        id: `DappazonModule_ListItem_${index}`, // ✅ Unique ID
        from: deployer, // ✅ Ensures deployer is listing the item
      }
    );
  });

  return { dappazon };
});

export default DappazonModule;
