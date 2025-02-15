import { Dappazon } from "../typechain-types"; // Import the generated contract type
import { expect } from "chai";
import { ContractTransactionResponse, Signer } from "ethers";
import hre from "hardhat";

// convert eth to wei 
const tokens = (r: number) => {
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
  let transaction: ContractTransactionResponse;
  let dappazonAddress: string;



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
      await transaction.wait();

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


  describe("Buying", () => {

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
      await transaction.wait();

      transaction = await dappazon.connect(buyer).buy(ID, { value: COST });
      await transaction.wait();


    });


    it("Should update buyer's order count", async () => {
      const buyerAddress = await buyer.getAddress();
      const result = await dappazon.orderCount(buyerAddress);
      expect(result).to.equal(1);
    });

    it("Should add an order", async () => {
      const buyerAddress = await buyer.getAddress();
      const order = await dappazon.orders(buyerAddress, 1);
      expect(order.time).to.be.greaterThan(0);
      expect(order.item.name).to.equal(NAME);
    });

    it("Should update the contract balance", async () => {
      dappazonAddress = await dappazon.getAddress();
      const result = await hre.ethers.provider.getBalance(dappazonAddress);
      expect(result).to.equal(COST);

    });

    it("Should emit buy event", async () => {
      expect(transaction).to.emit(dappazon, "Buy");

    });
  });

  describe("Withdrawing", () => {
    let balanceBefore: bigint; // Explicitly type as bigint
    let deployerAddress: string; // Explicitly type as string

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
      await transaction.wait();

      transaction = await dappazon.connect(buyer).buy(ID, { value: COST });
      await transaction.wait();

      deployerAddress = await deployer.getAddress();
      balanceBefore = await hre.ethers.provider.getBalance(deployerAddress);


      transaction = await dappazon.connect(deployer).withdraw();
      await transaction.wait();
    });

    it("Should update owner balance", async () => {
      const balanceAfter = await hre.ethers.provider.getBalance(deployerAddress);
      expect(balanceAfter).to.be.greaterThan(balanceBefore);  
    });

    it("Should update contract balance", async () => {
      dappazonAddress = await dappazon.getAddress();
      const result = await hre.ethers.provider.getBalance(dappazonAddress);
      expect(result).to.equal(0);  
    });
  });

});
