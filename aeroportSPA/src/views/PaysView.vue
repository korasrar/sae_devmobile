<script setup>
import { ref, onMounted, inject } from "vue";
import PaysItem from "../components/PaysItem.vue";

const provider = inject("aeroportProvider");

const pays = ref([]);
onMounted(() => {
  fetchPays();
});

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  });
}

function deletePays(id) {
  provider.deletePays(id).then(() => {
    // rafraichir la liste des pays
    fetchPays();
  });
}

function updatePays({ pays, newNomPays }) {
  provider.updatePays(pays, newNomPays).then(() => {
    // rafraichir la liste des pays
    fetchPays();
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
