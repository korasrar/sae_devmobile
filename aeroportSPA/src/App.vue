<script setup>
import { ref, provide } from "vue";

const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
const isDark = ref(prefersDark);
document.documentElement.setAttribute(
  "data-theme",
  isDark.value ? "dark" : "light",
);

function toggleTheme() {
  isDark.value = !isDark.value;
  document.documentElement.setAttribute(
    "data-theme",
    isDark.value ? "dark" : "light",
  );
}

import { AeroportProvider } from "./services/AeroportProvider";
import { API_ENDPOINT } from "./config.js";
const provider = new AeroportProvider(API_ENDPOINT);
provide("aeroportProvider", provider);
</script>

<template>
  <header class="app-header">
    <h1 class="app-title">AeroportSPA</h1>
    <nav class="app-nav">
      <RouterLink to="/home">Home</RouterLink>
      <RouterLink to="/vols">Vols</RouterLink>
      <RouterLink to="/aeroports">Aéroports</RouterLink>
      <RouterLink to="/compagnies">Compagnies</RouterLink>
      <RouterLink to="/villes">Villes</RouterLink>
      <RouterLink to="/pays">Pays</RouterLink>
    </nav>
    <span class="app-route">{{ $route.fullPath }}</span>
    <button
      class="theme-toggle"
      @click="toggleTheme"
      :title="isDark ? 'Switch to light mode' : 'Switch to dark mode'"
      :aria-label="isDark ? 'Switch to light mode' : 'Switch to dark mode'"
    >
      {{ isDark ? "☀️" : "🌙" }}
    </button>
  </header>
  <main>
    <notifications position="bottom left" />
    <RouterView />
  </main>
</template>
