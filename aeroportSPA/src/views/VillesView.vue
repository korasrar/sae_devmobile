<script setup>
import { ref, onMounted, inject } from 'vue'
import VilleItem from '../components/VilleItem.vue';

const provider = inject('aeroportProvider');

const villes = ref([]);

onMounted(() => {
  fetchVilles();
});

function fetchVilles() {
  provider.getVilles().then((data) => {
    villes.value = data;
  });
}

function deleteVille(id) {
  provider.deleteVille(id).then(() => {
    // rafraichir la liste des villes
    fetchVilles();
  });
}

function updateVille({ ville, newNomVille }) {
  provider.updateVille(ville, newNomVille).then(() => {
    // rafraichir la liste des villes
    fetchVilles();
  });
}

</script>

<template>
<div>
  <h1>Liste des villes</h1>
  <VilleItem v-for="ville in villes" :key="ville.id" :ville="ville" @delete="deleteVille" @update="updateVille" />
</div>
</template>
