<template>
  <main>
    <!-- <TheWelcome /> -->
    <h1>Dappazon</h1>
    <p v-if="state.account">Connected: {{ state.account }}</p>
    <button v-else @click="connectWallet">Connect Wallet</button>
  </main>
</template>

<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import TheWelcome from '../components/TheWelcome.vue';
import { ethers } from "ethers";
import type { IHomeState } from '@/types';

// State
const state = reactive<IHomeState>({ account: null });

let signer: ethers.JsonRpcSigner | null = null;
let provider: ethers.BrowserProvider;


// Function to connect wallet (A user will connect his wallet with this)
const connectWallet = async () => {
  if (!window.ethereum) {
    console.log("MetaMask is not installed");
    return;
  }

  try {
    provider = new ethers.BrowserProvider(window.ethereum);
    signer = await provider.getSigner();
    state.account = await signer.getAddress();
    console.log("Connected account:", state.account);
  } catch (error) {
    console.error("Error connecting wallet:", error);
  }
};


onMounted(async ()=>{
  if (!window.ethereum) {
    console.log("Metamask is not installed");
  
    // Use a default RPC URL (e.g., Infura, Alchemy, or another provider)
    // provider = new ethers.JsonRpcProvider("https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID");
  } else {
    provider = new ethers.BrowserProvider(window.ethereum); // Returns a BrowserProvider
    signer = await provider.getSigner();
    state.account = await signer.getAddress();
    console.log({ provider, signer, account: state.account });
  }
});


</script>
