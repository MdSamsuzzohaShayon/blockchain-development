<template>
    <div class="product-card">
        <div class="product-image">
            <img :src="product.image" :alt="product.name" />
        </div>
        <h3>{{ product.name }}</h3>
        <p class="price">{{ ethers.formatEther(product.cost) }} ETH</p>
        <button class="add-to-cart">View Details</button>
    </div>
</template>

<script setup lang="ts">
import { ethers } from "ethers";
import type { IProduct } from "@/types";

defineProps<{ product: IProduct }>();
</script>

<style scoped>
.product-card {
    background: white;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    transition: transform 0.3s ease;
}

.product-card:hover {
    transform: translateY(-5px);
}

.product-image img {
    width: 100%;
    border-radius: 8px;
}

.price {
    font-weight: bold;
    color: #e67e22;
}

.add-to-cart {
    background: linear-gradient(135deg, #f39c12, #e67e22);
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 8px;
}
</style>
