const { expect } = require('chai');
const { ethers } = require('hardhat');

// Convert currency to tokens
const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether');
}


describe('Escrow', () => {
    it('Saves the addresses', async ()=>{
        const RealEstate = await ethers.getContractFactory("RealEstate");
        const realEstate = await RealEstate.deploy();
        const contractAddress = await realEstate.getAddress();

        console.log("Real Estate Contract Address: ", contractAddress);
        
    });
});
