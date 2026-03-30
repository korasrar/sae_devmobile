<script setup>
import { ref } from "vue";

const props = defineProps({
  compagnie: Object,
  pays: Array,
});

const emit = defineEmits(["delete", "update"]);

const isEditing = ref(false);
const editedNom = ref("");
const editedIdPays = ref(null);

function deleteCompagnie() {
  emit("delete", props.compagnie.id);
}

function startEdit() {
  isEditing.value = true;
  editedNom.value = props.compagnie.nom;
  editedIdPays.value = props.compagnie.id_pays;
}

function cancelEdit() {
  isEditing.value = false;
}

function saveCompagnie() {
  emit("update", {
    compagnie: props.compagnie,
    newNom: editedNom.value,
    newIdPays: editedIdPays.value,
  });
  isEditing.value = false;
}
</script>

<template>
  <div class="item-card">
    <div v-if="!isEditing" class="item-display">
      <div class="item-info">
        <h3 class="item-name">{{ compagnie.nom }}</h3>
        <p class="item-detail">
          <span class="label">Pays:</span>
          <!--trouver le nom du pays-->
          <!--https://www.w3schools.com/jsreF/jsref_find.asp-->
          <span class="value">{{
            pays.find((p) => p.id_pays === compagnie.id_pays)?.nom_pays ||
            "Non défini"
          }}</span>
        </p>
      </div>
      <div class="item-actions">
        <button @click="startEdit" class="btn-edit">Modifier</button>
        <button @click="deleteCompagnie" class="btn-delete">Supprimer</button>
      </div>
    </div>
    <div v-else class="item-form" @keyup.enter="saveCompagnie">
      <h3 class="form-title">Modifier la compagnie</h3>
      <div class="form-group">
        <label class="form-label">
          Nom de la compagnie:
          <input v-model="editedNom" type="text" class="form-input" />
        </label>
      </div>
      <div class="form-group">
        <label class="form-label">
          Pays:
          <select v-model="editedIdPays" class="form-select">
            <option :value="null">-- Sélectionner un pays --</option>
            <option v-for="p in pays" :key="p.id_pays" :value="p.id_pays">
              {{ p.nom_pays }}
            </option>
          </select>
        </label>
      </div>
      <div class="form-actions">
        <button @click="saveCompagnie" class="btn-save">Enregistrer</button>
        <button @click="cancelEdit" class="btn-cancel">Annuler</button>
      </div>
    </div>
  </div>
</template>
