<template>
  <div
    class="bg-gradient-to-r from-black to-red-500 h-14 sm:h-24 flex justify-between rounded-b-lg shadow-xl shadow-stone-500"
  >
    <NuxtLink to="/">
      <img src="/img/alpha_img.png" alt="alpha" class="h-12 sm:h-20 sm:w-52 ml-1 mt-1 sm:mt-2" />
    </NuxtLink>
    <button class="z-20 outline-none" @click="toggleOpen()">
      <Bars3Icon v-if="!isOpen" class="menu-button" />
      <XMarkIcon v-if="isOpen" class="menu-button" />
    </button>
    <!-- button taking up whole screen so that screen becomes opaque when account settings is open
         tabindex = -1 makes it inaccessible from the keyboard with tab -->
    <button
      v-if="isOpen"
      @click="isOpen = false"
      class="fixed z-10 inset-0 h-full w-full bg-black opacity-25 cursor-default"
      tabindex="-1"
    ></button>
  </div>
  <nav :class="isOpen ? 'block' : 'hidden'" class="absolute z-10 right-3">
    <ul @click="isOpen = false" class="border rounded-md bg-white shadow-lg w-32 sm:w-36 mt-2 pr-2">
      <!-- header nav links depending on page -->
      <slot />
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { Bars3Icon, XMarkIcon } from "@heroicons/vue/24/solid";

const isOpen = ref(false);

function toggleOpen() {
  isOpen.value = !isOpen.value;
}

function handleEscape(e: KeyboardEvent) {
  if (e.key === "Esc" || e.key === "Escape") isOpen.value = false;
}

onMounted(() => {
  document.addEventListener("keydown", handleEscape);
});

onBeforeUnmount(() => {
  document.removeEventListener("keydown", handleEscape);
});
</script>
