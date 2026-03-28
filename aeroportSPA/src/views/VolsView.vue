<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";
import VolsItem from "../components/VolsItem.vue";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const vols = ref([]);
const aeroports = ref([]);
const compagnies = ref([]);

onMounted(() => {
  fetchVols();
  fetchAeroports();
  fetchCompagnies();
});

function fetchVols() {
  provider.getVols().then((data) => {
    vols.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function fetchAeroports() {
  provider.getAeroports().then((data) => {
    aeroports.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function fetchCompagnies() {
  provider.getCompagnies().then((data) => {
    compagnies.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function deleteVol(id) {
  provider.deleteVol(id)
    .then(() => {
      notify({ type: "success", text: "Vol supprimé avec succès !" });
      fetchVols();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function updateVol({ vol, newDateDepart, newDateArrive, newterminalDepart, newterminalArrive, newIdAeroportDepart, newIdAeroportArrive, newIdCompagnie }) {
  provider.updateVol(vol, newDateDepart, newDateArrive, newterminalDepart, newterminalArrive, newIdAeroportDepart, newIdAeroportArrive, newIdCompagnie)
    .then(() => {
      notify({ type: "success", text: "Vol modifié avec succès !" });
      fetchVols();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function addVol() {
  window.location.href = "/vols/add";
}
</script>

<template>
  <div class="list-container">
    <div>
      <h1>Liste des vols</h1>
      <button @click="addVol" class="btn-add">Ajouter un vol</button>
    </div>

    <div class="list-items">
      <VolsItem
        v-for="vol in vols"
        :key="vol.id"
        :vol="vol"
        :aeroports="aeroports"
        :compagnies="compagnies"
        @delete="deleteVol"
        @update="updateVol"
      />
    </div>
  </div>
</template>
