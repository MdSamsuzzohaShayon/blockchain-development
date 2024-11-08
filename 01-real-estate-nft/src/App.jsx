import { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import Navigation from './components/Navigation';

function App() {
  const [account, setAccount] = useState(null);
  const [isRequesting, setIsRequesting] = useState(false); // Flag for pending requests

  const loadBlockchainData = async () => {
    // Avoid making another request if one is already pending
    if (isRequesting) {
      console.log("Request is already pending. Please wait.");
      return;
    }

    setIsRequesting(true); // Set the flag to true before making the request

    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      console.log(provider);

      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      setAccount(accounts[0]);
      console.log(accounts[0]);
    } catch (error) {
      console.error("Error requesting permissions:", error);
    } finally {
      setIsRequesting(false); // Reset the flag once the request is complete
    }
  };

  useEffect(() => {
    loadBlockchainData();
  }, []);

  return (
    <div>
      <Navigation account={account} setAccount={setAccount} />
      <div className="cards__section">
        <h3>Welcome to Millow</h3>
      </div>
    </div>
  );
}

export default App;
