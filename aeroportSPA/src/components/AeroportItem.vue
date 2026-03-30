<script setup>
import { ref } from "vue";

const props = defineProps({
  aeroport: Object,
  villes: Array,
});

const emit = defineEmits(["delete", "update"]);

const isEditing = ref(false);
const editedNomAeroport = ref("");
const editedIdVille = ref(null);

function deleteAeroport() {
  emit("delete", props.aeroport.id);
}

function startEdit() {
  isEditing.value = true;
  editedNomAeroport.value = props.aeroport.nom_aeroport;
  editedIdVille.value = props.aeroport.id_ville;
}

function cancelEdit() {
  isEditing.value = false;
}

function saveAeroport() {
  emit("update", {
    aeroport: props.aeroport,
    newNomAeroport: editedNomAeroport.value,
    newIdVille: editedIdVille.value,
  });
  isEditing.value = false;
}
</script>

<template>
  <div class="item-card">
    <div v-if="!isEditing" class="item-display">
      <div class="item-info">
        <h3 class="item-name">{{ aeroport.nom_aeroport }}</h3>
        <p class="item-detail">
          <span class="label">Ville:</span>
          <!--trouver le nom de la ville cette fois-->
          <!--https://www.w3schools.com/jsreF/jsref_find.asp-->
          <span class="value">{{
            villes.find((v) => v.id_ville === aeroport.id_ville)?.nom_ville ||
            "Non définie"
          }}</span>
        </p>
      </div>
      <div class="item-actions">
        <button @click="startEdit" class="btn-edit">Modifier</button>
        <button @click="deleteAeroport" class="btn-delete">Supprimer</button>
      </div>
    </div>
    <div v-else class="item-form" @keyup.enter="saveAeroport">
      <h3 class="form-title">Modifier l'aéroport</h3>
      <div class="form-group">
        <label class="form-label">
          Nom de l'aéroport:
          <input v-model="editedNomAeroport" type="text" class="form-input" />
        </label>
      </div>
      <div class="form-group">
        <label class="form-label">
          Ville:
          <select v-model="editedIdVille" class="form-select">
            <option :value="null">-- Sélectionner une ville --</option>
            <option v-for="v in villes" :key="v.id_ville" :value="v.id_ville">
              {{ v.nom_ville }}
            </option>
          </select>
        </label>
      </div>
      <div class="form-actions">
        <button @click="saveAeroport" class="btn-save">Enregistrer</button>
        <button @click="cancelEdit" class="btn-cancel">Annuler</button>
      </div>
    </div>
  </div>
</template>
