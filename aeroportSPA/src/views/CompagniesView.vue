<script setup>
import { ref, onMounted, inject } from "vue";
import CompagnieItem from "../components/CompagnieItem.vue";

const provider = inject("aeroportProvider");

const compagnies = ref([]);
const pays = ref([]);

onMounted(() => {
  fetchCompagnies();
  fetchPays();
});

function fetchCompagnies() {
  provider.getCompagnies().then((data) => {
    compagnies.value = data;
  });
}

function fetchPays() {
  provider.getPays().then((data) => {
    pays.value = data;
  });
}

function deleteCompagnie(id) {
  provider.deleteCompagnie(id).then(() => {
    fetchCompagnies();
  });
}

function updateCompagnie({ compagnie, newNom, newIdPays }) {
  provider.updateCompagnie(compagnie, newNom, newIdPays).then(() => {
    fetchCompagnies();
  });
}
</script>

<template>
  <div class="list-container">
    <h1>Liste des compagnies</h1>
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
