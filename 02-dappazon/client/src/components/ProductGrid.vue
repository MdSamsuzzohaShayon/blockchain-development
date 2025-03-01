<template>
    <section class="products">
        <h2>Featured Products</h2>
        <div class="product-grid">
            <ProductCard v-for="product in products" :key="product.id" :product="product" @click="viewProduct(product)" />
        </div>
    </section>
</template>

<script setup lang="ts">
import type { IProduct } from "@/types";
import ProductCard from "./ProductCard.vue";

defineProps<{ products: IProduct[] }>();
const emit = defineEmits(["view-details"]);

const viewProduct = (product: IProduct) => {
    emit("view-details", product);
};
</script>

<style scoped>
.products {
    margin-top: 40px;
}

.products h2 {
    font-size: 2rem;
    margin-bottom: 20px;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
    gap: 25px;
}
</style>
