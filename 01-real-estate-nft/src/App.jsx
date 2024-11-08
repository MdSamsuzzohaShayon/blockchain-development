import { useEffect, useState } from 'react';
import { Grid2, Box, Typography } from '@mui/material';
import { ethers } from 'ethers';
import Navigation from './components/Navigation';
import Search from './components/Search';
import NFTCard from './components/NFTCard';

import RealEstate from './abis/RealEstate.json';
import Escrow from './abis/Escrow.json';

import config from './config.json';

function App() {
  const [provider, setProvider] = useState(null);
  const [escrow, setEscrow] = useState(null);
  const [account, setAccount] = useState(null);
  const [isRequesting, setIsRequesting] = useState(false); // Flag for pending requests
  const [homes, setHomes] = useState([]);

  const loadBlockchainData = async () => {
    if (isRequesting) {
      console.log("Request is already pending. Please wait.");
      return;
    }

    setIsRequesting(true);

    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      setProvider(provider);
      
      const network = await provider.getNetwork(); // Chain ID
      console.log({RealEstate: config[network.chainId].realEstate.address});
      console.log({Escrow: config[network.chainId].escrow.address});
      
      const realEstate = new ethers.Contract(config[network.chainId].realEstate.address, RealEstate, provider);
      const totalSupply = await realEstate.totalSupply();
      const ts = parseInt(totalSupply.toString(), 10);
      console.log({totalSupply: ts});
      const homes = [];

      for (let i = 1; i <= ts; i++) {
        const uri = await realEstate.tokenURI(i);
        const response = await fetch(uri);
        const metadata = await response.json();
        homes.push(metadata);
      }
      setHomes(homes);
      console.log(homes);
      

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

  useEffect(() => {
    loadBlockchainData();
  }, []);

  // Dummy NFT data (replace with actual data as needed)
  const nftData = [
    {
      title: 'Modern Apartment',
      description: '2 Bed • 1 Bath • 1200 sqft',
      imageUrl: 'https://images.pexels.com/photos/5998041/pexels-photo-5998041.jpeg',
      price: '2.5',
    },
    {
      title: 'Luxury Villa',
      description: '4 Bed • 3 Bath • 4000 sqft',
      imageUrl: 'https://images.pexels.com/photos/7902904/pexels-photo-7902904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      price: '5.8',
    },
    {
      title: 'Cozy Cottage',
      description: '1 Bed • 1 Bath • 700 sqft',
      imageUrl: 'https://images.pexels.com/photos/18868627/pexels-photo-18868627/free-photo-of-bedroom-in-cabin.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      price: '1.2',
    },
  ];

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
            <Grid2 xs={12} sm={6} md={4} key={index}>
              <NFTCard
                title={nft.name}
                description={nft.description}
                address={nft.address}
                imageUrl={nft.image}
                price={nft.attributes[0].value}
              />
            </Grid2>
          ))}
        </Grid2>
      </Box>
    </div>
  );
}

export default App;
