import { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import { AppBar, Toolbar, Typography, Container, Box, Button } from '@mui/material';
import FileUpload from './components/FileUpload';
import Display from './components/Display';
import './App.css';
import Upload from "./artifacts/contracts/Upload.sol/Upload.json";

import { MetaMaskInpageProvider } from '@metamask/providers';
import { Contract } from 'ethers';
import { JsonRpcSigner } from 'ethers';
import Modal from './components/Modal';

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

  const handleOpen = () => {
    setModalOpen(true);
  };

  const handleClose = () => {
    setModalOpen(false);
  };

  const handleConfirm = () => {
    console.log('Confirmed action');
    handleClose();
  };


  function handleAccountsChanged() {
    // Handle new accounts, or lack thereof.
    window.location.reload();
  }

  const wallet = async () => {
    // https://docs.ethers.org/v6/getting-started/
    let signer = null;

    let provider;
    if (typeof window !== 'undefined' && window.ethereum) {

      // Connect to the MetaMask EIP-1193 object. This is a standard
      // protocol that allows Ethers access to make all read-only
      // requests through MetaMask.
      provider = new ethers.BrowserProvider(window.ethereum);
      const code = await provider.getCode(CONTRACT_ADDRESS);
      console.log({ code });

      window.ethereum.on("accountsChanged", handleAccountsChanged)

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
  }, [])

  // useEffect(() => {

  //   if (window.ethereum) window.ethereum.on("accountsChanged", handleAccountsChanged);  // Or window.ethereum if you don't support EIP-6963.
  //   return () => {
  //     if (window.ethereum) window.ethereum.removeListener("accountsChanged", handleAccountsChanged);
  //   }
  // }, [])

  return (
    <div className="App">
      {/* AppBar for header */}
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            SDrive
          </Typography>
          <Button color="inherit">{account ? `Account: ${account}` : 'Not Connected'}</Button>
        </Toolbar>
      </AppBar>

      {/* Main content */}
      <Container sx={{ marginTop: 4 }}>
        <Box sx={{ textAlign: 'center', marginBottom: 4 }}>
          <Typography variant="h4" gutterBottom>
            Decentralized File Upload System
          </Typography>
          <Typography variant="subtitle1">
            Upload and manage files securely on the blockchain.
          </Typography>
        </Box>

        {/* File upload and Display components */}
        <Box
          sx={{
            display: 'flex',
            flexDirection: 'column',
            gap: 4,
            alignItems: 'center',
          }}
        >
          <FileUpload account={account} contract={contract} provider={provider} />
          <Display account={account} contract={contract} />
        </Box>
      </Container>

      <Button variant="contained" color="primary" onClick={handleOpen}>
        Open Modal
      </Button>

      {/* Use the custom Modal */}
      <Modal
        open={modalOpen}
        onClose={handleClose}
        title="Confirm Action"
        content="Are you sure you want to perform this action?"
        onConfirm={handleConfirm}
        confirmText="Confirm"
        cancelText="Cancel"
      />
    </div>
  );
}

export default App;