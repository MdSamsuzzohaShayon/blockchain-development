import { ethers } from "./ethers-6.7.esm.min.js"; 
import { abi, contractAddress } from "./constants.js"; 

/**
 * This script enables interaction with the Ethereum blockchain using MetaMask as the provider
 * and Ethers.js for executing smart contract functions like connecting, funding, withdrawing,
 * and retrieving the balance. The contract ABI and address are imported to interact with a specific contract.
 */

const connectButton = document.getElementById("connectButton");
const withdrawButton = document.getElementById("withdrawButton");
const fundButton = document.getElementById("fundButton");
const balanceButton = document.getElementById("balanceButton");

/**
 * Assign click event listeners to buttons that allow users to interact with MetaMask and the smart contract.
 * WHY: This allows the user to trigger different actions on the blockchain (e.g., connecting their wallet, 
 * funding the contract, etc.) through the UI.
 */
connectButton.onclick = handleConnect;
withdrawButton.onclick = handleWithdraw;
fundButton.onclick = handleFund;
balanceButton.onclick = handleGetBalance;

/**
 * Connects the user's MetaMask wallet to the dApp.
 * - Requests access to the user's MetaMask accounts and logs the available accounts.
 * - If MetaMask is not installed, prompts the user to install MetaMask.
 * 
 * WHY: Connecting to MetaMask is necessary because it serves as the user's gateway to the Ethereum network, 
 * allowing them to sign transactions and interact with smart contracts securely.
 * 
 * @async
 * @function handleConnect
 */
async function handleConnect() {
  if (typeof window.ethereum !== "undefined") {
    try {
      // Requests the user to authorize access to their MetaMask accounts.
      await ethereum.request({ method: "eth_requestAccounts" });
    } catch (error) {
      console.log(error); // Logs any errors encountered during the connection process.
    }
    connectButton.innerHTML = "Connected"; // Update button text to indicate successful connection.
    
    // Fetch and log the connected accounts.
    const accounts = await ethereum.request({ method: "eth_accounts" });
    console.log(accounts); // WHY: We log the accounts to verify the connection and debug issues.
  } else {
    connectButton.innerHTML = "Please install MetaMask"; // Prompts the user to install MetaMask if it's not available.
  }
}

/**
 * Withdraws funds from the smart contract using the connected MetaMask account.
 * - Sends a transaction to the smart contract's `withdraw` method and waits for confirmation.
 * 
 * WHY: Users may want to withdraw funds from the contract. This function interacts with the smart contract's 
 * `withdraw` function to allow them to do so securely via MetaMask.
 * 
 * @async
 * @function handleWithdraw
 */
async function handleWithdraw() {
  console.log(`Withdrawing...`);
  if (typeof window.ethereum !== "undefined") {
    const provider = new ethers.BrowserProvider(window.ethereum); // WHY: We use the provider from MetaMask to sign and send transactions.
    await provider.send('eth_requestAccounts', []); // Requests the user to connect their MetaMask accounts.
    
    const signer = await provider.getSigner(); // WHY: The signer represents the user's account and is used to sign transactions.
    const contract = new ethers.Contract(contractAddress, abi, signer); // WHY: We need the contract instance to call its methods like `withdraw`.
    
    try {
      // Sends the withdraw transaction to the blockchain and waits for it to be mined (confirmed in one block).
      const transactionResponse = await contract.withdraw();
      await transactionResponse.wait(1); // WHY: Waiting ensures the transaction is confirmed on the blockchain.
      console.log("Done!");
    } catch (error) {
      console.log(error); // Logs any errors encountered during the withdrawal process.
    }
  } else {
    withdrawButton.innerHTML = "Please install MetaMask"; // Prompts the user to install MetaMask if not available.
  }
}

/**
 * Funds the smart contract with a specified amount of Ether.
 * - Takes user input for the amount of Ether to fund and sends the transaction to the contract.
 * 
 * WHY: Users may want to fund the smart contract (e.g., for depositing funds or participating in a service). 
 * This function allows them to send Ether to the contract.
 * 
 * @async
 * @function handleFund
 */
async function handleFund() {
  const ethAmount = document.getElementById("ethAmount").value; // WHY: We take the user's input for the amount of Ether they want to send.
  console.log(`Funding with ${ethAmount}...`);
  
  if (typeof window.ethereum !== "undefined") {
    const provider = new ethers.BrowserProvider(window.ethereum); // WHY: Using MetaMask as the provider allows us to access the user's account securely.
    await provider.send('eth_requestAccounts', []); // Requests the user's MetaMask accounts.
    
    const signer = await provider.getSigner(); // WHY: We need the signer to send the transaction on behalf of the user.
    const contract = new ethers.Contract(contractAddress, abi, signer); // WHY: The contract instance is necessary to call its `fund` method.

    try {
      // Sends the funding transaction to the smart contract and waits for confirmation.
      const transactionResponse = await contract.fund(2, "0x0000000000000000000000000000000000000000", {
        value: ethers.parseEther(ethAmount), // WHY: We convert the user input from ETH to Wei (the smallest denomination of ETH).
      });
      await transactionResponse.wait(1); // WHY: Waiting ensures that the transaction is confirmed before proceeding.
    } catch (error) {
      console.log(error); // Logs any errors encountered during the funding process.
    }
  } else {
    fundButton.innerHTML = "Please install MetaMask"; // Prompts the user to install MetaMask if not available.
  }
}

/**
 * Retrieves the current Ether balance of the smart contract.
 * - Queries the blockchain for the contract's balance and logs the result.
 * 
 * WHY: Users may want to check the balance of the contract (e.g., to see how much Ether is locked in it). 
 * This function retrieves and displays the contract's balance.
 * 
 * @async
 * @function handleGetBalance
 */
async function handleGetBalance() {
  if (typeof window.ethereum !== "undefined") {
    const provider = new ethers.BrowserProvider(window.ethereum); // WHY: We use the MetaMask provider to access the blockchain.
    
    try {
      // Retrieves the contract's Ether balance and logs it in a human-readable format.
      const balance = await provider.getBalance(contractAddress);
      console.log(ethers.formatEther(balance)); // WHY: Formatting the balance from Wei to Ether makes it easier for users to understand.
    } catch (error) {
      console.log(error); // Logs any errors encountered during the balance retrieval process.
    }
  } else {
    balanceButton.innerHTML = "Please install MetaMask"; // Prompts the user to install MetaMask if not available.
  }
}
