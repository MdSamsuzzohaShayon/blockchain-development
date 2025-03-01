<script setup lang="ts">
import { ref, onMounted } from "vue";
import { RouterLink, RouterView } from "vue-router";
import { ethers } from "ethers";

const account = ref<string | null>(null);
let provider: ethers.BrowserProvider | null = null;
let signer: ethers.JsonRpcSigner | null = null;

// Function to connect wallet
const connectWallet = async () => {
  if (!window.ethereum) {
    console.log("MetaMask is not installed");
    return;
  }

  try {
    provider = new ethers.BrowserProvider(window.ethereum);
    signer = await provider.getSigner();
    account.value = await signer.getAddress();
    console.log("Connected:", account.value);
  } catch (error) {
    console.error("Error connecting wallet:", error);
  }
};

</script>

<template>
  <header class="navbar">
    <div class="container">
      <RouterLink to="/" class="logo">🛒 Dappazon</RouterLink>
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/shop">Shop</RouterLink>
        <RouterLink to="/about">About</RouterLink>
      </nav>
      <button @click="connectWallet" class="wallet-btn">
        {{ account ? `Connected: ${account.slice(0, 6)}...${account.slice(-4)}` : "Connect Wallet" }}
      </button>
    </div>
  </header>

  <RouterView />

  <footer class="footer">
    <p>&copy; 2024 Dappazon. All rights reserved.</p>
  </footer>
</template>

<style scoped>
/* Global Layout */
.container {
  max-width: 1200px;
  margin: auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* Navbar */
.navbar {
  background: #222;
  color: white;
  padding: 15px 0;
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.navbar .logo {
  font-size: 1.5rem;
  font-weight: bold;
  text-decoration: none;
  color: white;
}

.navbar nav {
  display: flex;
  gap: 15px;
}

.navbar nav a {
  color: white;
  text-decoration: none;
  font-size: 1rem;
  transition: 0.3s;
}

.navbar nav a:hover {
  color: #f39c12;
}

/* Wallet Button */
.wallet-btn {
  background: #f39c12;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  color: white;
  transition: 0.3s;
}

.wallet-btn:hover {
  background: #d67c00;
}

/* Footer */
.footer {
  text-align: center;
  padding: 20px;
  background: #222;
  color: white;
  margin-top: 50px;
}
</style>
