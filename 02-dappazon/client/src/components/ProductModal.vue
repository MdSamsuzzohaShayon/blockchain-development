<template>
    <Teleport to="body">
        <div v-if="isOpen" class="modal-overlay" @click.self="closeModal">
            <div class="modal-content">
                <!-- Close Button -->
                <button class="close-btn" @click="closeModal">×</button>

                <!-- Product Image -->
                <div class="modal-body">
                    <div class="product-image">
                        <img :src="product.image" :alt="product.name" />
                    </div>

                    <!-- Product Details -->
                    <div class="product-details">
                        <h2 class="product-name">{{ product.name }}</h2>
                        <p class="category">Category: <strong>{{ product.category }}</strong></p>
                        <p class="price">{{ ethers.formatEther(product.cost) }} ETH</p>
                        <p class="stock">Stock: <span :class="{ 'out-of-stock': product.stock === 0 }">{{ product.stock >
                            0 ? `${product.stock} available` : "Out of stock" }}</span></p>

                        <!-- Rating -->
                        <div class="rating">
                            <span v-for="star in 5" :key="star" class="star"
                                :class="{ 'filled': star <= product.rating }">★</span>
                        </div>

                        <!-- Dummy description -->
                        <p class="description">
                            {{ "This is a premium product with top-notch quality. Perfect for your needs." }}
                        </p>

                        <!-- Buy Button -->
                        <!-- Buy Button -->
                        <button class="buy-btn" :disabled="product.stock === 0" @click="buyProduct">
                            Buy Now
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<script setup lang="ts">
import { defineProps, defineEmits } from "vue";
import { ethers } from "ethers";
import type { IProduct } from "@/types";

const props = defineProps<{
    isOpen: boolean;
    product: IProduct;
}>();

const emit = defineEmits(["close", "buy"]);

const closeModal = () => {
    emit("close");
};

// Buy Product
const buyProduct = () => {
    emit("buy", props.product.id,props.product.cost);
};
</script>

<style scoped>
/* Overlay */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

/* Modal */
.modal-content {
    background: white;
    width: 90%;
    max-width: 600px;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    position: relative;
    animation: fadeIn 0.3s ease-in-out;
}

/* Close Button */
.close-btn {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 1.8rem;
    background: none;
    border: none;
    cursor: pointer;
    color: #888;
    transition: 0.3s ease-in-out;
}

.close-btn:hover {
    color: #333;
}

/* Modal Body */
.modal-body {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

/* Product Image */
.product-image img {
    width: 100%;
    max-height: 250px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 15px;
}

/* Product Details */
.product-name {
    font-size: 1.8rem;
    color: #222;
    font-weight: bold;
    margin-bottom: 8px;
}

.category {
    font-size: 1rem;
    color: #666;
    margin-bottom: 10px;
}

.price {
    font-size: 1.5rem;
    font-weight: bold;
    color: #e67e22;
    margin-bottom: 10px;
}

.stock {
    font-size: 1rem;
    font-weight: bold;
    color: #27ae60;
    margin-bottom: 10px;
}

.stock.out-of-stock {
    color: #e74c3c;
}

/* Rating */
.rating {
    margin: 10px 0;
}

.star {
    font-size: 1.4rem;
    color: #ccc;
}

.star.filled {
    color: #f39c12;
}

/* Description */
.description {
    font-size: 1rem;
    color: #555;
    margin: 15px 0;
    line-height: 1.4;
}

/* Buy Button */
.buy-btn {
    background: linear-gradient(135deg, #f39c12, #e67e22);
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.2rem;
    font-weight: bold;
    transition: 0.3s ease-in-out;
}

.buy-btn:hover {
    background: linear-gradient(135deg, #e67e22, #d35400);
    transform: scale(1.05);
}

.buy-btn:disabled {
    background: #bbb;
    cursor: not-allowed;
}

/* Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: scale(0.9);
    }

    to {
        opacity: 1;
        transform: scale(1);
    }
}
</style>
