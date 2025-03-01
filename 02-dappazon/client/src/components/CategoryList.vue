<template>
    <section class="categories">
        <h2>Shop by Category</h2>
        <div class="category-list">
            <div v-for="category in categories" :key="category" class="category">
                {{ category }}
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
defineProps<{ categories: string[] }>();
</script>

<style scoped>
.categories {
    margin-bottom: 30px;
}

.categories h2 {
    font-size: 1.8rem;
    margin-bottom: 15px;
}

.category-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 15px;
}

.category {
    text-transform: capitalize;
    background: linear-gradient(135deg, #f39c12, #e67e22);
    padding: 12px 18px;
    border-radius: 20px;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.category:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
}
</style>
