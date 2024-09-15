import { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import './App.css';
import Upload from "./artifacts/contracts/Upload.sol/Upload.json";

import { MetaMaskInpageProvider } from '@metamask/providers';
import { Contract } from 'ethers';
import { JsonRpcSigner } from 'ethers';

declare global {
  interface Window {
    ethereum?: MetaMaskInpageProvider;
  }
}

// Get contract address after deploying the contract with Hardhat
const CONTRACT_ADDRESS: string = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

function App() {
  const [account, setAccount] = useState<string>('');
  const [contract, setContract] = useState<Contract | null>(null);
  const [modalOpen, setModalOpen] = useState<boolean>(false);
  const [provider, setProvider] = useState<null | JsonRpcSigner>(null);


  const wallet = async () => {
    // https://docs.ethers.org/v6/getting-started/
    let signer = null;

    let provider;
    if (typeof window !== 'undefined' && window.ethereum) {

      // Connect to the MetaMask EIP-1193 object. This is a standard
      // protocol that allows Ethers access to make all read-only
      // requests through MetaMask.
      provider = new ethers.BrowserProvider(window.ethereum);

      // It also provides an opportunity to request access to write
      // operations, which will be performed by the private key
      // that MetaMask manages for the user.
      signer = await provider.getSigner();
      const signerAddress = await signer.getAddress();
      console.log({ signerAddress });
      setAccount(signerAddress);
      // Create a contract
      const uploadContract = new Contract(CONTRACT_ADDRESS, Upload.abi, signer);
      console.log({ uploadContract });
      setContract(uploadContract);
      setProvider(signer);

    } else {
      // If MetaMask is not installed, we use the default provider,
      // which is backed by a variety of third-party services (such
      // as INFURA). They do not have private keys installed,
      // so they only have read-only access
      console.log("MetaMask not installed; using read-only defaults");
      provider = ethers.getDefaultProvider();
    }
  }

  useEffect(() => {
    wallet();
    // return () => {

    // }
  }, [])


  return (
    <div className='App'>
      App
    </div>
  )
}

export default App;
