const { expect } = require('chai');
const { ethers } = require('hardhat');

// Convert currency to tokens
const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether');
}


describe('Escrow', () => {
    let realEstate = null, escrow = null;
    let buyer = null, seller = null, inspector = null, lender = null;
    let realEstateAddress = null, escrowAddress = null;

    beforeEach(async () => {
        // get all hardhat free addresses
        const accounts = await ethers.getSigners();
        // console.log("All free accounts from HardHat: ", accounts);
        buyer = accounts[0];
        seller = accounts[1];
        inspector = accounts[2];
        lender = accounts[3];


        // Deploy Real Estate
        const RealEstate = await ethers.getContractFactory("RealEstate");
        realEstate = await RealEstate.deploy();
        realEstateAddress = await realEstate.getAddress();

        // Mint
        // console.log("Real Estate Contract Address: ", contractAddress);
        let transaction = await realEstate.connect(seller).mint("https://ipfs.io/ipfs/QmQUozrHLAusXDxrvsESJ3PYB3rUeUuBAvVWw6nop2uu7c/1.json");
        await transaction.wait();

        // Deploy Escrow
        const Escrow = await ethers.getContractFactory("Escrow");
        escrow = await Escrow.deploy(
            realEstateAddress, // nftAddress
            seller.address,
            inspector.address,
            lender.address
        );
        escrowAddress = await escrow.getAddress();

        // Approve property
        // transaction = await realEstate.connect(seller).approve(escrowAddress, 1);
        // await transaction.wait();

        // List property 
        // transaction = await escrow.connect(seller).list(1);
        // await transaction.wait();
    });

    describe("Deployment", async () => {
        let result = null;
        it("Returns NFT address", async () => {
            result = await escrow.nftAddress();
            expect(result).to.be.equal(realEstateAddress);
        });
        it("Returns Seller address", async () => {
            result = await escrow.seller();
            expect(result).to.be.equal(seller.address);
        });
        it("Returns Inspector address", async () => {
            result = await escrow.inspector();
            expect(result).to.be.equal(inspector.address);
        });
        it("Returns Lender address", async () => {
            result = await escrow.lender();
            expect(result).to.be.equal(lender.address);
        });
    });

    describe("Listing", async () => {
        let result = null;
        it("Updates ownership", async () => {
            expect(await realEstate.ownerOf(1)).to.be.equal(escrowAddress);
        });
    });
});
