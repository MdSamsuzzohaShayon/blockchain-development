import { Dappazon } from "../typechain-types"; // Import the generated contract type
import { expect } from "chai";
import { Signer } from "ethers";
import hre from "hardhat";

describe("Dappazon", function () {
  let dappazon: Dappazon; // Use the generated contract type
  let deployer: Signer; // Explicitly type deployer
  let buyer: Signer; // Explicitly type buyer


  beforeEach(async () => {
    // Setup accounts
    [deployer, buyer] = await hre.ethers.getSigners();

    const DappazonFactory = await hre.ethers.getContractFactory("Dappazon");
    dappazon = (await DappazonFactory.deploy()) as Dappazon;
    await dappazon.waitForDeployment(); // Ensures the contract is fully deployed
  });

  describe("Deployment", ()=>{
    it("Should sets the owner", async ()=>{
      expect(await dappazon.owner()).to.equal(deployer);
    });
    it("Should have a name", async () => {
      const name: string = await dappazon.name(); // Type is automatically inferred
      expect(name).to.equal("Dappazon");
    });
  })

});
