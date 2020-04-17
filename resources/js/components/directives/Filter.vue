<template>
    <span>
        <i class="fas fa-arrows-alt-v text-secondary" v-if="name !== sort"></i>
        <i class="fas fa-long-arrow-alt-down text-secondary" v-if="order === 'desc' && name === sort"></i>
        <i class="fas fa-long-arrow-alt-up text-secondary" v-if="order === 'asc' && name === sort"></i>
    </span>
</template>

<script>
    export default {
        name: "FilterList",
        props: ['order', 'sort', 'name']
    }
</script>

<style scoped>

</style>