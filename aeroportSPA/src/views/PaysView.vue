<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";
import PaysItem from "../components/PaysItem.vue";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const pays = ref([]);
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

function deletePays(id) {
  provider.deletePays(id)
    .then(() => {
      notify({ type: "success", text: "Pays supprimé avec succès !" });
      fetchPays();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function updatePays({ pays, newNomPays }) {
  provider.updatePays(pays, newNomPays)
    .then(() => {
      notify({ type: "success", text: "Pays modifié avec succès !" });
      fetchPays();
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function addPays() {
  // rediriger vers la page d'ajout de pays
  window.location.href = "/pays/add";
}
</script>

<template>
  <div class="list-container">
    <div>
      <h1>Liste des pays</h1>
      <button @click="addPays" class="btn-add">Ajouter un pays</button>
    </div>
    <div class="list-items">
      <PaysItem
        v-for="pays in pays"
        :key="pays.id"
        :pays="pays"
        @delete="deletePays"
        @update="updatePays"
      />
    </div>
  </div>
</template>
