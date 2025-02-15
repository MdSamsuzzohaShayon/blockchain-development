import { Dappazon } from "../typechain-types"; // Import the generated contract type
import { expect } from "chai";
import { ContractTransactionResponse, Signer } from "ethers";
import hre from "hardhat";

// convert eth to wei 
const tokens = (r: number)=>{
  return hre.ethers.parseUnits(r.toString(), 'ether');
}

const ID = 1;
const NAME = "Shoes";
const CATEGORY = "Clothing";
const IMAGE = "https://bafybeianqgchjc7ztelteo5mvlofkj734zd6bo5ztsraeygxqtas7zd57m.ipfs.dweb.link?filename=shoes.jpg";
const COST = tokens(1); // 1 ether
const RATING = 4;
const STOCK = 5;

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

  describe("Deployment", () => {
    it("Should sets the owner", async () => {
      expect(await dappazon.owner()).to.equal(deployer);
    });
    it("Should have a name", async () => {
      const name: string = await dappazon.name(); // Type is automatically inferred
      expect(name).to.equal("Dappazon");
    });
  });

  describe("Listing", () => {
    let transaction: ContractTransactionResponse;

    beforeEach(async () => {
      transaction = await dappazon.connect(deployer).list(
        ID,
        NAME,
        CATEGORY,
        IMAGE,
        COST,
        RATING,
        STOCK
      );
    });

    it("Should return item attributes", async () => {
      const item = await dappazon.items(ID);
      expect(item.id).to.equal(ID);
      expect(item.name).to.equal(NAME);
      expect(item.category).to.equal(CATEGORY);
      expect(item.image).to.equal(IMAGE);
      expect(item.cost).to.equal(COST);
      expect(item.rating).to.equal(RATING);
      expect(item.stock).to.equal(STOCK);
    });

    it("Should emit list event", async () => {
      expect(transaction).to.emit(dappazon, "List");
    });
  });

});
