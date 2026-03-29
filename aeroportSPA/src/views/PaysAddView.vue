<script setup>
import { ref, inject } from "vue";
import { useNotification } from "@kyvg/vue3-notification";

const provider = inject("aeroportProvider");
const { notify } = useNotification();

const newNomPays = ref("");

function addPays() {
  provider.addPays(newNomPays.value)
    .then(() => {
      notify({ type: "success", text: "Pays ajouté avec succès !" });
      newNomPays.value = "";
    })
    .catch((error) => {
      notify({ type: "error", text: error.message });
    });
}

function goToPays() {
  window.location.href = "/pays";
}

</script>

<template>
  <div class="add-container">
    <h1>Ajouter un pays</h1>
    <form class="add-form" @submit.prevent="addPays">
      <div class="form-group">
        <label class="form-label">Nom du pays</label>
        <input v-model="newNomPays" class="form-input" required />
      </div>
      <button type="submit" class="btn-add" @click="goToPays">Ajouter</button>
    </form>
  </div>
</template>
