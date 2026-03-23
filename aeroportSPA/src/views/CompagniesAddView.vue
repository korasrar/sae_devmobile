<script setup>
import { ref, onMounted, inject } from "vue";

const provider = inject("aeroportProvider");

const pays = ref([]);
const newNomCompagnie = ref("");
const newIdPays = ref("");

onMounted(() => {
  fetchPays();
});

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  });
}

function addCompagnie() {
  provider.addCompagnie(newNomCompagnie.value, newIdPays.value).then(() => {
    // réinitialiser les champs du formulaire
    newNomCompagnie.value = "";
    newIdPays.value = "";
  });
}

function goToCompagnies() {
  window.location.href = "/compagnies";
}

</script>

<template>
  <div class="add-container">
    <h1>Ajouter une compagnie</h1>
    <form class="add-form" @submit.prevent="addCompagnie">
      <div class="form-group">
        <label class="form-label">Nom de la compagnie</label>
        <input v-model="newNomCompagnie" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Pays</label>
        <select v-model="newIdPays" class="form-input" required>
          <option v-for="pays in pays" :key="pays.id" :value="pays.id">
            {{ pays.nom_pays }}
          </option>
        </select>
      </div>
      <button type="submit" class="btn-add" @click="goToCompagnies">Ajouter</button>
    </form>
  </div>
</template>
