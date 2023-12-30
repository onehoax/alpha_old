<template>
  <NuxtLayout name="default">
    <template #header>
      <AppHeader>
        <MenuLink name="Home">
          <HomeIcon class="header-icon" />
        </MenuLink>
        <MenuLink name="Users">
          <UsersIcon class="header-icon" />
        </MenuLink>
      </AppHeader>
    </template>
    <div class="bg-green-200">Users Page</div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { HomeIcon, UsersIcon } from "@heroicons/vue/24/solid";

definePageMeta({
  layout: false
});
</script>
