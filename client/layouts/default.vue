<template>
  <div class="flex flex-col h-screen justify-between">
    <header>
      <slot name="header" />
    </header>
    <main>
      <div class="mx-2">
        <slot />
      </div>
    </main>
    <footer>
      <AppFooter />
    </footer>
  </div>
</template>

<script setup lang="ts">
useHead({
  bodyAttrs: {
    class: "text-stone-600"
  }
});
</script>
