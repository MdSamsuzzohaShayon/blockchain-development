// App.jsx
import { useEffect, useState } from 'react';
import { Grid2, Box, Typography, Modal } from '@mui/material';
import { ethers } from 'ethers';
import Navigation from './components/Navigation';
import Search from './components/Search';
import NFTCard from './components/NFTCard';

import RealEstate from './abis/RealEstate.json';
import Escrow from './abis/Escrow.json';

import config from './config.json';
import Home from './components/Home';


function App() {
  const [provider, setProvider] = useState(null);
  const [escrow, setEscrow] = useState(null);
  const [account, setAccount] = useState(null);
  const [isRequesting, setIsRequesting] = useState(false);
  const [homes, setHomes] = useState([]);
  const [selectedHome, setSelectedHome] = useState(null); // For modal

  const loadBlockchainData = async () => {
    if (isRequesting) {
      console.log("Request is already pending. Please wait.");
      return;
    }

    setIsRequesting(true);

    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      setProvider(provider);

      const network = await provider.getNetwork();
      const realEstate = new ethers.Contract(config[network.chainId].realEstate.address, RealEstate, provider);
      const totalSupply = await realEstate.totalSupply();
      const ts = parseInt(totalSupply.toString(), 10);
      const homes = [];

      for (let i = 1; i <= ts; i++) {
        const uri = await realEstate.tokenURI(i);
        const response = await fetch(uri);
        const metadata = await response.json();
        homes.push(metadata);
      }
      setHomes(homes);

      const escrow = new ethers.Contract(config[network.chainId].escrow.address, Escrow, provider);
      setEscrow(escrow);

      window.ethereum.on("accountsChanged", async () => {
        const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
        const account = ethers.utils.getAddress(accounts[0]);
        setAccount(account);
      });
    } catch (error) {
      console.error("Error requesting permissions:", error);
    } finally {
      setIsRequesting(false);
    }
  };

  const handleCardClick = (home) => {
    console.log("Card clicked");
    
    setSelectedHome(home);
  };

  const handleCloseModal = () => {
    setSelectedHome(null);
  };

  useEffect(() => {
    loadBlockchainData();
  }, []);

  return (
    <div>
      <Navigation account={account} setAccount={setAccount} />
      <Search />
      <Box sx={{ textAlign: 'center', py: 4 }}>
        <Typography variant="h4" component="h3" gutterBottom>
          Welcome to Millow
        </Typography>
      </Box>
      <Box sx={{ px: 4, py: 2 }}>
        <Grid2 container spacing={4} justifyContent="center">
          {homes.map((nft, index) => (
            <Grid2 xs={12} sm={6} md={4} key={index} onClick={() => handleCardClick(nft)}>
              <NFTCard
                title={nft.name}
                description={nft.description}
                address={nft.address}
                imageUrl={nft.image}
                price={nft.attributes[0].value}
                attributes={nft.attributes}
                
              />
            </Grid2>
          ))}
        </Grid2>
      </Box>

      {/* Modal for NFT Details */}
      <Modal open={!!selectedHome} onClose={handleCloseModal} aria-labelledby="modal-title">
        <Home selectedHome={selectedHome} provider={provider} escrow={escrow} account={account} onClose={handleCloseModal} />
      </Modal>
    </div>
  );
}

export default App;
