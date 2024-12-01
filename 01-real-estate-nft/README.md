# Real Estate NFT DApp

 - Till __https://youtu.be/jcgfQEbptdo?t=15017__

## Deployment Process on Test Network
 - Step 1: Run Tests: Before deploying, ensure all tests pass to verify your smart contract's functionality.
    ```
    npx hardhat test
    ```
    This runs all the tests in your project.
    Fix any errors before proceeding.
 - Step 2: Start a Local Blockchain Node: Launch a local Ethereum blockchain node to simulate the test network.
    ```
    npx hardhat node
    ```
    This will start a local blockchain on localhost.
    You’ll see a list of test accounts with their private keys.
 - Step 3: Deploy the Smart Contract: Run the deployment script to deploy your contract to the local test network.
    ```
    npx hardhat run scripts/deploy.js --network localhost
    ```
    Ensure your deploy.js script is correctly configured.
    Use the localhost network to connect to the local blockchain started in Step 2.
    The console output will display the contract address after deployment.
 - Step 4: Prepare NFT Files: 
    - Open IPFS Desktop (or any other IPFS client). 
    - Upload all your NFT asset files (e.g., images, metadata). 
    - Copy the generated IPFS link (e.g., ipfs://Qm...) for your uploaded assets.
 - Step 5: Update Deployment Script
    - Modify your deploy.js script to include the IPFS link:
    - Locate the section in deploy.js where the NFT metadata URI is defined.
    - Replace it with the IPFS link you copied in Step 4.
    - Example:
        ```
        const nftMetadataURI = "ipfs://QmYourUploadedFileHash";
        ```
 - Final Step: Verify Deployment
    - After deployment, verify that:
    - The contract address is displayed in the console.
    - The NFT metadata URI correctly references your uploaded IPFS files.
    - You’re now ready to interact with your smart contract on the local test network! 🎉

## Technology Stack & Tools

- Solidity (Writing Smart Contracts & Tests)
- Javascript (React & Testing)
- [Hardhat](https://hardhat.org/) (Development Framework)
- [Ethers.js](https://docs.ethers.io/v5/) (Blockchain Interaction)
- [React.js](https://reactjs.org/) (Frontend Framework)

## Requirements For Initial Setup
- Install [NodeJS](https://nodejs.org/en/)

## Setting Up
### 1. Clone/Download the Repository

### 2. Install Dependencies:
`$ npm install`

### 3. Run tests
`$ npx hardhat test`

### 4. Start Hardhat node
`$ npx hardhat node`

### 5. Run deployment script
In a separate terminal execute:
`$ npx hardhat run ./scripts/deploy.js --network localhost`

### 7. Start frontend
`$ npm run start`