<script setup>
import { ref, onMounted, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const compagnies = ref([]);
const aeroports = ref([]);

const newIdCompagnie = ref("");
const newIdAeroportDepart = ref("");
const newIdAeroportArrive = ref("");
const newDateDepart = ref("");
const newDateArrive = ref("");
const newTerminalDepart = ref("");
const newTerminalArrive = ref("");

onMounted(() => {
  fetchCompagnies();
  fetchAeroports();
});

function fetchCompagnies() {
  provider.getCompagnies().then((data) => {
    compagnies.value = data;
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

function addVol() {
  provider.addVol(newIdCompagnie.value, newIdAeroportDepart.value, newIdAeroportArrive.value, newDateDepart.value, newDateArrive.value, newTerminalDepart.value, newTerminalArrive.value)
    .then(() => {
      notify({ type: "success", text: "Vol ajouté avec succès !" });
      newIdCompagnie.value = "";
      newIdAeroportDepart.value = "";
      newIdAeroportArrive.value = "";
      newDateDepart.value = "";
      newDateArrive.value = "";
      newTerminalDepart.value = "";
      newTerminalArrive.value = "";
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function goToVols() {
  window.location.href = "/vols";
}
</script>

<template>
  <div class="add-container">
    <h1>Ajouter un vol</h1>
    <form class="add-form" @submit.prevent="addVol">
      <div class="form-group">
        <label class="form-label">Compagnie</label>
        <select v-model="newIdCompagnie" class="form-input" required>
          <option v-for="compagnie in compagnies" :key="compagnie.id" :value="compagnie.id">
            {{ compagnie.nom }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Aéroport de départ</label>
        <select v-model="newIdAeroportDepart" class="form-input" required>
          <option v-for="aeroport in aeroports" :key="aeroport.id" :value="aeroport.id">
            {{ aeroport.nom_aeroport }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Aéroport d'arrivée</label>
        <select v-model="newIdAeroportArrive" class="form-input" required>
          <option v-for="aeroport in aeroports" :key="aeroport.id" :value="aeroport.id">
            {{ aeroport.nom_aeroport }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Terminal de départ</label>
        <input type="text" v-model="newTerminalDepart" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Terminal d'arrivée</label>
        <input type="text" v-model="newTerminalArrive" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Date de départ</label>
        <input type="datetime-local" v-model="newDateDepart" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label">Date d'arrivée</label>
        <input type="datetime-local" v-model="newDateArrive" class="form-input" required />
      </div>
      <button type="submit" class="btn-add" @click="goToVols">Ajouter</button>
    </form>
  </div>
</template>
