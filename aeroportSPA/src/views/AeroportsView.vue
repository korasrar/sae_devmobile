<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";
import AeroportItem from "../components/AeroportItem.vue";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const aeroports = ref([]);
const villes = ref([]);

onMounted(() => {
  fetchAeroports();
  fetchVilles();
});

function fetchAeroports() {
  provider.getAeroports().then((data) => {
    aeroports.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function fetchVilles() {
  provider.getVilles().then((data) => {
    villes.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function deleteAeroport(id) {
  provider.deleteAeroport(id)
    .then(() => {
      notify({ type: "success", text: "Aéroport supprimé avec succès !" });
      fetchAeroports();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function updateAeroport({ aeroport, newNomAeroport, newIdVille }) {
  provider.updateAeroport(aeroport, newNomAeroport, newIdVille)
    .then(() => {
      notify({ type: "success", text: "Aéroport modifié avec succès !" });
      fetchAeroports();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
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
