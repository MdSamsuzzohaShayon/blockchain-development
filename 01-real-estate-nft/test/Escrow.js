const { expect } = require('chai'); // Chai is an assertion library used to validate test results.
const { ethers } = require('hardhat'); // Hardhat provides an Ethereum development environment.

/**
 * Helper function to convert a numerical value to tokens (ether in this case).
 * In real life, this is similar to converting an amount from dollars to cents for accuracy.
 */
const tokens = (n) => ethers.utils.parseUnits(n.toString(), 'ether');

describe('Escrow Contract', () => {
    let realEstate, escrow;
    let buyer, seller, inspector, lender;

    /**
     * Before each test, we set up a fresh environment:
     * - Deploy the contracts.
     * - Create an NFT representing property.
     * - List it for sale.
     * 
     * Think of this like setting up a new bank account (escrow account) before a property sale.
     * Every time we do a transaction, it uses the fresh account so tests don't interfere with each other.
     */
    beforeEach(async () => {
        [buyer, seller, inspector, lender] = await ethers.getSigners(); // Fetch accounts acting as different participants.

        // Deploy a RealEstate contract representing a registry of properties (NFTs).
        const RealEstate = await ethers.getContractFactory("RealEstate");
        realEstate = await RealEstate.deploy();
        await realEstate.deployed();

        // Mint an NFT to represent a property. Here, `ipfs://...` is a link to property info.
        // This is similar to creating a unique digital title deed for a house.
        const mintTransaction = await realEstate.connect(seller).mint("ipfs://Qme6h3W3Wn7GjuguBHRYVZ258qcnk1L4iesUsScFgRCBhd");
        await mintTransaction.wait();

        // Deploy the Escrow contract where the buyer deposits money and the ownership transfer happens.
        const Escrow = await ethers.getContractFactory("Escrow");
        escrow = await Escrow.deploy(realEstate.address, seller.address, inspector.address, lender.address);
        await escrow.deployed();

        // Seller approves the Escrow to manage the NFT (like authorizing a bank to handle funds in an escrow).
        const approveTransaction = await realEstate.connect(seller).approve(escrow.address, 1);
        await approveTransaction.wait();

        // Seller lists the property for sale on the escrow platform.
        // It's similar to putting a house on the market with terms for price and deposit.
        const listTransaction = await escrow.connect(seller).list(1, buyer.address, tokens(10), tokens(5));
        await listTransaction.wait();
    });

    describe("Deployment", () => {
        it("Should return the correct NFT address", async () => {
            // Verify the NFT (property) address is correctly set in the Escrow contract.
            // In real life, this is like ensuring the bank has a record of the property being sold.
            const nftAddress = await escrow.nftAddress();
            expect(nftAddress).to.equal(realEstate.address);
        });

        it("Should return the correct seller address", async () => {
            const escrowSeller = await escrow.seller();
            expect(escrowSeller).to.equal(seller.address);
        });

        it("Should return the correct inspector address", async () => {
            const escrowInspector = await escrow.inspector();
            expect(escrowInspector).to.equal(inspector.address);
        });

        it("Should return the correct lender address", async () => {
            const escrowLender = await escrow.lender();
            expect(escrowLender).to.equal(lender.address);
        });
    });

    describe("Listing Property", () => {
        it("Should correctly update listing status", async () => {
            // Check if the property is marked as listed in the contract.
            // Similar to confirming the property has been posted on a real estate website.
            const isListed = await escrow.isListed(1);
            expect(isListed).to.be.equal(true);
        });

        it("Should transfer ownership of NFT to Escrow contract", async () => {
            // Check that the Escrow now "owns" the property NFT, holding it during the sale.
            const nftOwner = await realEstate.ownerOf(1);
            expect(nftOwner).to.equal(escrow.address);
        });

        it("Should set the correct buyer for the listing", async () => {
            const listingBuyer = await escrow.buyer(1);
            expect(listingBuyer).to.equal(buyer.address);
        });

        it("Should set the correct purchase price", async () => {
            const purchasePrice = await escrow.purchasePrice(1);
            expect(purchasePrice).to.equal(tokens(10));
        });

        it("Should set the correct escrow deposit amount", async () => {
            const escrowAmount = await escrow.escrowAmount(1);
            expect(escrowAmount).to.equal(tokens(5));
        });
    });

    describe("Deposits", () => {
        it("Should update the contract balance after earnest deposit", async () => {
            // Buyer deposits the escrow amount. Think of it like wiring the deposit money to an escrow account.
            const depositTransaction = await escrow.connect(buyer).depositEarnest(1, { value: tokens(5) });
            await depositTransaction.wait();

            // Verify contract balance is updated.
            const contractBalance = await escrow.getBalance();
            expect(contractBalance).to.equal(tokens(5));
        });
    });

    describe("Inspection", () => {
        it("Should correctly update inspection status", async () => {
            // Inspector updates inspection status.
            // This is similar to a home inspector reporting that the property is in good condition.
            const inspectionTransaction = await escrow.connect(inspector).updateInspectionStatus(1, true);
            await inspectionTransaction.wait();

            // Verify inspection status.
            const inspectionPassed = await escrow.inspectionPassed(1);
            expect(inspectionPassed).to.be.equal(true);
        });
    });

    describe("Approval Process", () => {
        it("Should update approval status for each participant", async () => {
            // Buyer, Seller, and Lender approve the sale. Think of this as all parties signing off.
            await escrow.connect(buyer).approveSale(1).then(tx => tx.wait());
            await escrow.connect(seller).approveSale(1).then(tx => tx.wait());
            await escrow.connect(lender).approveSale(1).then(tx => tx.wait());

            // Verify approvals
            expect(await escrow.approval(1, buyer.address)).to.be.equal(true);
            expect(await escrow.approval(1, seller.address)).to.be.equal(true);
            expect(await escrow.approval(1, lender.address)).to.be.equal(true);
        });
    });

    describe("Finalizing Sale", () => {
        beforeEach(async () => {
            // Set up all necessary conditions to finalize the sale.
            await escrow.connect(buyer).depositEarnest(1, { value: tokens(5) }).then(tx => tx.wait());
            await escrow.connect(inspector).updateInspectionStatus(1, true).then(tx => tx.wait());
            await escrow.connect(buyer).approveSale(1).then(tx => tx.wait());
            await escrow.connect(seller).approveSale(1).then(tx => tx.wait());
            await escrow.connect(lender).approveSale(1).then(tx => tx.wait());

            // Lender sends funds to escrow for final payment.
            await lender.sendTransaction({ to: escrow.address, value: tokens(5) });

            // Finalize sale, transferring ownership to the buyer.
            await escrow.connect(seller).finalizeSale(1).then(tx => tx.wait());
        });

        it("Should transfer property ownership to the buyer", async () => {
            // Ownership should now be with the buyer, just like receiving the title deed after a house purchase.
            const newOwner = await realEstate.ownerOf(1);
            expect(newOwner).to.equal(buyer.address);
        });

        it("Should reset escrow contract balance to zero", async () => {
            // The contract balance should be zero as funds are distributed.
            const finalBalance = await escrow.getBalance();
            expect(finalBalance).to.equal(0);
        });
    });
});
