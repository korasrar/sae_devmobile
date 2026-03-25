<script setup>
import { ref, onMounted, inject } from "vue";
import VilleItem from "../components/VilleItem.vue";

const provider = inject("aeroportProvider");

const villes = ref([]);
const pays = ref([]);

onMounted(() => {
  fetchVilles();
  fetchPays();
});

function fetchVilles() {
  provider.getVilles().then((data) => {
    villes.value = data;
  });
}

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  });
}

function deleteVille(id) {
  provider.deleteVille(id).then(() => {
    // rafraichir la liste des villes
    fetchVilles();
  });
}

function updateVille({ ville, newNomVille, newIdPays }) {
  provider.updateVille(ville, newNomVille, newIdPays).then(() => {
    // rafraichir la liste des villes
    fetchVilles();
  });
}

function addVille() {
  // rediriger vers la page d'ajout de ville
  window.location.href = "/villes/add";
}
</script>

<template>
  <div class="list-container">
    <div>
      <h1>Liste des villes</h1>
      <button @click="addVille" class="btn-add">Ajouter une ville</button>
    </div>
    <div class="list-items">
      <VilleItem
        v-for="ville in villes"
        :key="ville.id"
        :ville="ville"
        :pays="pays"
        @delete="deleteVille"
        @update="updateVille"
      />
    </div>
  </div>
</template>
