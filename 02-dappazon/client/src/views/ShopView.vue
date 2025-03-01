<template>
    <div class="shop-container">
        <h1>Shop</h1>

        <!-- Categories Section -->
        <CategoryList :categories="categories" />

        <!-- Featured Products -->
        <ProductGrid :products="products" @view-details="openModal" />

        <!-- Product Modal -->
        <ProductModal v-if="selectedProduct" :isOpen="modalOpen" :product="selectedProduct" @close="modalOpen = false"
            @buy="handleBuy" />


    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import { ethers } from "ethers";
import config from "../config.json" with { type: "json" };
import ABI from "../abis/Dappazon.json";
import type { IProduct } from "@/types";

import CategoryList from "../components/CategoryList.vue";
import ProductGrid from "../components/ProductGrid.vue";
import ProductModal from "../components/ProductModal.vue";

const categories = ref<string[]>([]);
const products = ref<IProduct[]>([]);

const signer = ref<ethers.Signer | null>(null);
const provider = ref<ethers.Provider | null>(null);
const dappazon = ref<ethers.Contract | null>(null);


const selectedProduct = ref<IProduct | null>(null);
const modalOpen = ref(false);


// Events
const openModal = (product: IProduct) => {
    selectedProduct.value = product;
    modalOpen.value = true;
};



const handleBuy = async (productId: number, productCost: number) => {
    try {
        if (!window.ethereum) {
            console.error("No Ethereum provider found");
            return;
        }

        const browserProvider = new ethers.BrowserProvider(window.ethereum);
        const signer = await browserProvider.getSigner(); // Get the signer

        const network = await browserProvider.getNetwork();
        const chainId = network.chainId.toString() as keyof typeof config;
        const contractAddress = config[chainId]?.dappazon?.address;

        if (!contractAddress) {
            console.error("Contract address not found in config");
            return;
        }

        // Attach the signer to the contract
        const dappazonContract = new ethers.Contract(contractAddress, ABI, signer);

        const valueInWei = ethers.parseEther(productCost.toString());

        console.log("Sending transaction...");
        const transaction = await dappazonContract.buy(productId, { value: productCost });

        console.log("Transaction sent:", transaction);
        await transaction.wait();
        console.log("Transaction confirmed.");

    } catch (error) {
        console.error("Error while buying:", error);
    }
};




// On component mounted
onMounted(async () => {
    if (window.ethereum) {
        const browserProvider = new ethers.BrowserProvider(window.ethereum);
        provider.value = browserProvider;
        const signerAccount = await browserProvider.getSigner();
        signer.value = signerAccount;

        const network = await browserProvider.getNetwork();
        const chainId = network.chainId.toString() as keyof typeof config;
        const contractAddress = config[chainId]?.dappazon?.address;

        if (contractAddress) {
            const dappazonContract = new ethers.Contract(contractAddress, ABI, browserProvider);
            dappazon.value = dappazonContract;

            const categorySet = new Set<string>();
            const items: IProduct[] = [];

            for (let i = 0; i < 9; i++) {
                const item = await dappazonContract.items(i + 1);
                categorySet.add(item.category);
                items.push(item);
            }
            categories.value = [...categorySet];
            products.value = items;
        }
    }
});



</script>

<style scoped>
.shop-container {
    max-width: 1200px;
    margin: auto;
    padding: 20px;
    font-family: "Poppins", sans-serif;
    text-align: center;
}

h1 {
    font-size: 2.5rem;
    margin-bottom: 20px;
    color: #333;
}
</style>
