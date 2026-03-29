<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const pays = ref([]);
const newNomVille = ref("");
const newIdPays = ref("");

onMounted(() => {
  fetchPays();
});

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function addVille() {
  provider.addVille(newNomVille.value, newIdPays.value)
    .then(() => {
      notify({ type: "success", text: "Ville ajoutée avec succès !" });
      newNomVille.value = "";
      newIdPays.value = "";
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function goToVilles() {
  window.location.href = "/villes";
}

</script>

<template>
  <div class="add-container">
    <h1>Ajouter une ville</h1>
    <form class="add-form" @submit.prevent="addVille">
      <div class="form-group">
        <label class="form-label">Nom de la ville</label>
        <input v-model="newNomVille" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Pays</label>
        <select v-model="newIdPays" class="form-input" required>
          <option v-for="pays in pays" :key="pays.id" :value="pays.id">
            {{ pays.nom_pays }}
          </option>
        </select>
      </div>
      <button type="submit" class="btn-add" @click="goToVilles">Ajouter</button>
    </form>
  </div>
</template>
