// Import the Hardhat Runtime Environment (HRE).
// HRE provides tools and functionalities for deploying, testing, and interacting with contracts.
// You can use this directly with Node.js (`node <script>`) or run with `npx hardhat run <script>`.
const hre = require("hardhat");

// Utility function to convert values into Ether units.
// In real life, think of this as converting dollars to cents for precise financial calculations.
const tokens = (n) => hre.ethers.utils.parseUnits(n.toString(), 'ether');

// Define the main async function for deployment and interaction
async function main() {
  // Retrieve accounts/signers provided by Hardhat for testing.
  // Real-life analogy: buyers, sellers, inspectors, and lenders are different parties in a real estate transaction.
  const [buyer, seller, inspector, lender] = await hre.ethers.getSigners();

  // Deploy the RealEstate contract.
  // Think of this as setting up a new property database where each property is tokenized as an NFT.
  const RealEstate = await hre.ethers.getContractFactory("RealEstate");
  const realEstate = await RealEstate.deploy();
  await realEstate.deployed(); // Wait for deployment.

  // Display the address of the deployed RealEstate contract.
  console.log(`Deployed Real Estate Contract at: ${realEstate.address}`);
  console.log(`Minting 3 properties....`);

  /* 
  Define metadata for each property. This data (images, descriptions) is hosted on IPFS, a decentralized file storage.
  In real-life terms, these are digital documents representing property details.
  */
  const propertyMetadatas = [
    "ipfs://Qme6h3W3Wn7GjuguBHRYVZ258qcnk1L4iesUsScFgRCBhd", // 1.json
    "ipfs://QmQjPis6fW2887u8xAhzfFmhPhHsr6npJbJvEhonAcdGmK", // 2.json
    "ipfs://QmPajSdW6oBJKgptmcqTdAmswsPgmAUm63ShUc9jTNXnZW", // 3.json
  ];

  // Mint NFTs for each property. The seller is the initial owner of each property.
  // Real-life equivalent: Registering properties under the seller's name in a property registry.
  for (let i = 0; i < propertyMetadatas.length; i++) {
    const mintTransaction = await realEstate.connect(seller).mint(propertyMetadatas[i]); // e.g., mint 1.json
    await mintTransaction.wait(); // Wait for each mint transaction to be confirmed.
  }

  // Deploy the Escrow contract, linking it to the RealEstate contract.
  // The Escrow acts as a middleman handling transactions securely between buyer and seller.
  const Escrow = await hre.ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(realEstate.address, seller.address, inspector.address, lender.address);
  await escrow.deployed();
  console.log(`Deployed Escrow Contract at: ${escrow.address}`);

  // Grant the Escrow contract approval to transfer property NFTs on behalf of the seller.
  // This is like giving power to an escrow company to transfer ownership.
  for (let i = 0; i < propertyMetadatas.length; i += 1) {
    const transaction = await realEstate.connect(seller).approve(escrow.address, i + 1); // Approve each property by ID.
    await transaction.wait();
  }

  // List properties in the Escrow contract for sale, with details for each:
  // property ID, buyer, purchase price, and down payment.
  let transaction = await escrow.connect(seller).list(1, buyer.address, tokens(20), tokens(10)); // Property 1 for 20 ether with 10 ether down payment.
  await transaction.wait();

  transaction = await escrow.connect(seller).list(2, buyer.address, tokens(15), tokens(5)); // Property 2 for 15 ether with 5 ether down payment.
  await transaction.wait();

  transaction = await escrow.connect(seller).list(3, buyer.address, tokens(10), tokens(5)); // Property 3 for 10 ether with 5 ether down payment.
  await transaction.wait();

  console.log("Finished"); // Indicate completion.
}

// Standard error handling for async/await functions to catch deployment or execution issues.
main().catch((error) => {
  console.error(error); // Log any error encountered.
  process.exitCode = 1; // Ensure a non-zero exit code for error handling in environments like CI/CD.
});
