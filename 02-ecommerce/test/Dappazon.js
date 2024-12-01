// npx hardhat test
const { expect } = require("chai");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether');
}

describe("Dappazon", async () => {
  let dappazon;
  let deployer, buyer;

  beforeEach(async () => {
    [deployer, buyer] = await ethers.getSigners();
    // console.log({ deployer: deployer.address, buyer: buyer.address });

    const Dappazon = await ethers.getContractFactory("Dappazon");
    dappazon = await Dappazon.deploy();
  });

  describe("Deployment", () => {
    it("Sets the owner", async () => {
      const showOwner = await dappazon.owner();
      expect(showOwner).to.equal(deployer.address);
    });
  });

  describe("Deployment", () => {
    let transaction;
    beforeEach(async () => {
      transaction =  await dappazon.connect(deployer).list(
        1,
        "shoes",
        "Clothing",
        "Image",
        1,
        4,
        5
      );
      await transaction.wait();

    });
    it("Returns item attributes", async () => {
      const item = await dappazon.items(1);
      expect(item.id).to.equal(1)
    });
  });
});
