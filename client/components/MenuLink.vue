<template>
  <li class="base-heading-link text-sm sm:text-base my-2">
    <NuxtLink :to="getPath()" class="flex justify-between items-center px-2 border-r-4 border-white">
      <slot />
      <span>{{ name }}</span>
    </NuxtLink>
  </li>
</template>

<script setup lang="ts">
const { name } = defineProps(["name"]);

function getPath() {
  const lowerName = name.toLowerCase();
  if (lowerName === "home") return "/";
  else return `/${lowerName}`;
}
</script>
