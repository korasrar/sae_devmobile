<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";
import CompagnieItem from "../components/CompagnieItem.vue";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const compagnies = ref([]);
const pays = ref([]);

onMounted(() => {
  fetchCompagnies();
  fetchPays();
});

function fetchCompagnies() {
  provider.getCompagnies().then((data) => {
    compagnies.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  }).catch((error) => {
    notify({ type: "error", text: error.message });
  });
}

function deleteCompagnie(id) {
  provider.deleteCompagnie(id)
    .then(() => {
      notify({ type: "success", text: "Compagnie supprimée avec succès !" });
      fetchCompagnies();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function updateCompagnie({ compagnie, newNom, newIdPays }) {
  provider.updateCompagnie(compagnie, newNom, newIdPays)
    .then(() => {
      notify({ type: "success", text: "Compagnie modifiée avec succès !" });
      fetchCompagnies();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function addCompagnie() {
  // rediriger vers la page d'ajout de compagnie
  window.location.href = "/compagnies/add";
}
</script>

<template>
  <div class="list-container">
    <div>
      <h1>Liste des compagnies</h1>
      <button @click="addCompagnie" class="btn-add">
        Ajouter une compagnie
      </button>
    </div>
    <div class="list-items">
      <CompagnieItem
        v-for="compagnie in compagnies"
        :key="compagnie.id"
        :compagnie="compagnie"
        :pays="pays"
        @delete="deleteCompagnie"
        @update="updateCompagnie"
      />
    </div>
  </div>
</template>
