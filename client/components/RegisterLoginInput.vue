<template>
  <input
    class="w-full border-b text-xs outline-none"
    :type="input.type"
    :name="input.name"
    :placeholder="input.name"
    :pattern="input.pattern"
    :minlength="input.minlength"
    :maxlength="input.maxlength"
    autocomplete="off"
    required
  />
</template>

<script setup lang="ts">
defineProps(["input"]);
</script>
