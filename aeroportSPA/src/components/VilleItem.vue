<script setup>
import { ref } from "vue";

const props = defineProps({
  ville: Object,
  pays: Array,
});

const emit = defineEmits(["delete", "update"]);

const isEditing = ref(false);
const editedNomVille = ref("");
const editedIdPays = ref(null);

function deleteVille() {
  // emit delete avec l'id de la ville
  emit("delete", props.ville.id);
}

function startEdit() {
  isEditing.value = true;
  editedNomVille.value = props.ville.nom_ville;
  editedIdPays.value = props.ville.id_pays;
}

function cancelEdit() {
  isEditing.value = false;
}

function saveVille() {
  emit("update", {
    ville: props.ville,
    newNomVille: editedNomVille.value,
    newIdPays: editedIdPays.value,
  });
  isEditing.value = false;
}
</script>

<template>
  <div class="item-card">
    <!-- si on édite pas ( etat de base ) -->
    <div v-if="!isEditing" class="item-display">
      <div class="item-info">
        <h3 class="item-name">{{ ville.nom_ville }}</h3>
        <p class="item-detail">
          <span class="label">Pays:</span>
          <!--trouver le nom du pays-->
          <!--https://www.w3schools.com/jsreF/jsref_find.asp-->
          <span class="value">{{
            pays.find((p) => p.id === ville.id_pays)?.nom_pays || "Non défini"
          }}</span>
        </p>
      </div>
      <div class="item-actions">
        <button @click="startEdit" class="btn-edit">Modifier</button>
        <button @click="deleteVille" class="btn-delete">Supprimer</button>
      </div>
    </div>
    <div v-else class="item-form" @keyup.enter="saveVille">
      <h3 class="form-title">Modifier la ville</h3>
      <div class="form-group">
        <label class="form-label">
          Nom de la ville:
          <input v-model="editedNomVille" type="text" class="form-input" />
        </label>
      </div>
      <div class="form-group">
        <label class="form-label">
          Pays:
          <select v-model="editedIdPays" class="form-select">
            <option :value="null">-- Sélectionner un pays --</option>
            <option v-for="p in pays" :key="p.id" :value="p.id">
              {{ p.nom_pays }}
            </option>
          </select>
        </label>
      </div>
      <div class="form-actions">
        <button @click="saveVille" class="btn-save">Enregistrer</button>
        <button @click="cancelEdit" class="btn-cancel">Annuler</button>
      </div>
    </div>
  </div>
</template>
