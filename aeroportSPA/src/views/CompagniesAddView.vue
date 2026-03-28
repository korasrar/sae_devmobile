<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const pays = ref([]);
const newNomCompagnie = ref("");
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

function addCompagnie() {
  provider.addCompagnie(newNomCompagnie.value, newIdPays.value)
    .then(() => {
      notify({ type: "success", text: "Compagnie ajoutée avec succès !" });
      newNomCompagnie.value = "";
      newIdPays.value = "";
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
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
