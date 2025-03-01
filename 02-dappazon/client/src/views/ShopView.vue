<template>
    <div class="shop-container">
        <h1>Shop</h1>

        <!-- Categories Section -->
        <CategoryList :categories="categories" />

        <!-- Featured Products -->
        <ProductGrid :products="products" @view-details="openModal" />

        <!-- Product Modal -->
        <ProductModal v-if="selectedProduct" :isOpen="modalOpen" :product="selectedProduct" @close="closeModal"
            @buy="handleBuy" />
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref, shallowRef, watch } from "vue";
import { ethers } from "ethers";
import config from "../config.json" with { type: "json" };
import ABI from "../abis/Dappazon.json";
import type { IProduct, TEvents } from "@/types";

import CategoryList from "../components/CategoryList.vue";
import ProductGrid from "../components/ProductGrid.vue";
import ProductModal from "../components/ProductModal.vue";

// Reactive state
const categories = ref<string[]>([]);
const products = ref<IProduct[]>([]);
const selectedProduct = ref<IProduct | null>(null);
const modalOpen = ref(false);
const purchasedItem = ref<number | null>(null);
const orderId = ref<number | null>(null);

// Ethereum related state (use shallowRef to avoid deep reactivity)
const provider = shallowRef<ethers.BrowserProvider | null>(null);
const signer = shallowRef<ethers.Signer | null>(null);
const contractAddress = ref<string | ethers.Addressable | null>(null);
const dappazonContract = shallowRef<ethers.Contract | null>(null);

// Open modal with selected product
const openModal = (product: IProduct) => {
    selectedProduct.value = product;
    modalOpen.value = true;
};

// Close modal
const closeModal = () => {
    modalOpen.value = false;
    selectedProduct.value = null;
};

// Handle buy action
const handleBuy = async (productId: number, productCost: number) => {
    if (!contractAddress.value || !signer.value) {
        console.error("Contract address or signer is not available");
        return;
    }

    try {
        const contract = new ethers.Contract(contractAddress.value, ABI, signer.value);
        console.log("Sending transaction...");
        const transaction = await contract.buy(productId, { value: productCost });
        console.log("Transaction sent:", transaction);
        await transaction.wait();
        purchasedItem.value = productId;
        console.log("Transaction confirmed.");
    } catch (error) {
        console.error("Error while buying:", error);
    }
};

const fetchOrderDetails = async () => {
    if (!purchasedItem.value) {
        console.error("No product has been bought recently!");
        return;
    }
    if (!dappazonContract.value) {
        console.error("There is no contract");
        return;
    }
    const events = await dappazonContract.value.queryFilter("Buy");
    if (!events || events.length === 0) {
        console.error("No events found!");
        return;
    }

    const account = await signer.value?.getAddress();
    if (!account) {
        console.error("No account found!");
        return;
    }

    // Parse the logs properly
    const orders = events
        .map((log) => {
            try {
                return dappazonContract.value?.interface.parseLog(log);
            } catch (error) {
                return null; // Skip logs that cannot be parsed
            }
        })
        .filter((parsedLog) => parsedLog !== null)
        .filter((parsedLog) => parsedLog?.args.buyer === account && parsedLog?.args.itemId.toString() === purchasedItem.value?.toString());

    if (orders.length === 0) {
        console.error("No orders found!");
        return;
    }

    // Get orderId from parsed event log
    const orderIdFromEvent = orders[0]?.args?.orderId;
    if (!orderIdFromEvent) {
        console.error("Order ID not found in event");
        return;
    }

    // Fetch the order details from the smart contract
    const order = await dappazonContract.value.orders(account, orderIdFromEvent);
    orderId.value = order;
    console.log("Order: ", order);

};


watch(purchasedItem, async (newProductId, oldProductId) => {
    if (!newProductId) {
        console.error("Product ID not updated");

        return;
    }
    fetchOrderDetails();
});
// Fetch categories and products on component mount
onMounted(async () => {
    if (window.ethereum) {
        provider.value = new ethers.BrowserProvider(window.ethereum);
        signer.value = await provider.value.getSigner();

        const network = await provider.value.getNetwork();
        const chainId = network.chainId.toString() as keyof typeof config;
        contractAddress.value = config[chainId]?.dappazon?.address;

        if (contractAddress.value) {
            dappazonContract.value = new ethers.Contract(contractAddress.value, ABI, provider.value);

            const categorySet = new Set<string>();
            const items: IProduct[] = [];

            for (let i = 0; i < 9; i++) {
                const item = await dappazonContract.value.items(i + 1);
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