<script setup>
import { ref, onMounted, inject } from "vue";
import AeroportItem from "../components/AeroportItem.vue";

const provider = inject("aeroportProvider");

const aeroports = ref([]);
const villes = ref([]);

onMounted(() => {
  fetchAeroports();
  fetchVilles();
});

function fetchAeroports() {
  provider.getAeroports().then((data) => {
    aeroports.value = data;
  });
}

function fetchVilles() {
  provider.getVilles().then((data) => {
    villes.value = data;
  });
}

function deleteAeroport(id) {
  provider.deleteAeroport(id).then(() => {
    fetchAeroports();
  });
}

function updateAeroport({ aeroport, newNomAeroport, newIdVille }) {
  provider.updateAeroport(aeroport, newNomAeroport, newIdVille).then(() => {
    fetchAeroports();
  });
}

function addAeroport() {
  // rediriger vers la page d'ajout d'aéroport
  window.location.href = "/aeroports/add";
}
</script>

<template>
  <div class="list-container">
    <div>
      <h1>Liste des aéroports</h1>
      <button @click="addAeroport" class="btn-add">Ajouter un aéroport</button>
    </div>

    <div class="list-items">
      <AeroportItem
        v-for="aeroport in aeroports"
        :key="aeroport.id"
        :aeroport="aeroport"
        :villes="villes"
        @delete="deleteAeroport"
        @update="updateAeroport"
      />
    </div>
  </div>
</template>
