// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

const tokens = (n) => hre.ethers.utils.parseUnits(n.toString(), 'ether');

async function main() {
  const [buyer, seller, inspector, lender] = await hre.ethers.getSigners();

  const RealEstate = await hre.ethers.getContractFactory("RealEstate");
  const realEstate = await RealEstate.deploy();
  await realEstate.deployed();

  console.log(`Deployed Real Estate Contract at: ${realEstate.address}`);
  console.log(`Minting 3 properties....`);

  
  const propertyMetadatas = [
    "ipfs://Qme6h3W3Wn7GjuguBHRYVZ258qcnk1L4iesUsScFgRCBhd", // 1.json
    "ipfs://QmQjPis6fW2887u8xAhzfFmhPhHsr6npJbJvEhonAcdGmK", // 2.json
    "ipfs://QmPajSdW6oBJKgptmcqTdAmswsPgmAUm63ShUc9jTNXnZW", // 3.json
  ];
  
  
  for (let i = 0; i < propertyMetadatas.length; i++) {
    const mintTransaction = await realEstate.connect(seller).mint(propertyMetadatas[i]); // 1.json
    await mintTransaction.wait();
  }


  // Deploy Escrow
  const Escrow = await hre.ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(realEstate.address, seller.address, inspector.address, lender.address);
  await escrow.deployed();
  console.log(`Deployed Escrow Contract at: ${escrow.address}`);


  // Approve properties
  for(let i = 0; i < propertyMetadatas.length; i += 1){
    const transaction = await realEstate.connect(seller).approve(escrow.address, i + 1);
    await transaction.wait();
  }

  let transaction = await escrow.connect(seller).list(1, buyer.address, tokens(20), tokens(10));
  await transaction.wait();

  transaction = await escrow.connect(seller).list(2, buyer.address, tokens(15), tokens(5));
  await transaction.wait();

  transaction = await escrow.connect(seller).list(3, buyer.address, tokens(10), tokens(5));
  await transaction.wait();

  console.log("Finished");
  

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
