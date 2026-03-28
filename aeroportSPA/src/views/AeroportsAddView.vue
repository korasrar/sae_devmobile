<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const villes = ref([]);
const newNomAeroport = ref("");
const newIdVille = ref("");

onMounted(() => {
  fetchVilles();
});

function fetchVilles() {
  provider.getVilles().then((data) => {
    villes.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function addAeroport() {
  provider.addAeroport(newNomAeroport.value, newIdVille.value)
    .then(() => {
      notify({ type: "success", text: "Aéroport ajouté avec succès !" });
      newNomAeroport.value = "";
      newIdVille.value = "";
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function goToAeroports() {
  window.location.href = "/aeroports";
}

</script>

<template>
  <div class="add-container">
    <h1>Ajouter un aéroport</h1>
    <form class="add-form" @submit.prevent="addAeroport">
      <div class="form-group">
        <label class="form-label">Nom de l'aéroport</label>
        <input v-model="newNomAeroport" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Ville</label>
        <select v-model="newIdVille" class="form-input" required>
          <option v-for="ville in villes" :key="ville.id" :value="ville.id">
            {{ ville.nom_ville }}
          </option>
        </select>
      </div>
      <button type="submit" class="btn-add" @click="goToAeroports">Ajouter</button>
    </form>
  </div>
</template>
