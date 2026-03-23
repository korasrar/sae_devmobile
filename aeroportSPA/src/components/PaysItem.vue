<script setup>
import { ref } from "vue";

const props = defineProps({
  pays: Object,
});

const emit = defineEmits(["delete", "update"]);

const isEditing = ref(false);
const editedNomPays = ref("");

function deletePays() {
  emit("delete", props.pays.id);
}

function startEdit() {
  isEditing.value = true;
  editedNomPays.value = props.pays.nom_pays;
}

function cancelEdit() {
  isEditing.value = false;
}

function savePays() {
  emit("update", {
    pays: props.pays,
    newNomPays: editedNomPays.value,
  });
  isEditing.value = false;
}
</script>

<template>
  <div class="item-card">
    <div v-if="!isEditing" class="item-display">
      <div class="item-info">
        <h3 class="item-name">{{ pays.nom_pays }}</h3>
      </div>
      <div class="item-actions">
        <button @click="startEdit" class="btn-edit">Modifier</button>
        <button @click="deletePays" class="btn-delete">Supprimer</button>
      </div>
    </div>
    <div v-else class="item-form" @keyup.enter="savePays">
      <h3 class="form-title">Modifier le pays</h3>
      <div class="form-group">
        <label class="form-label">
          Nom du pays:
          <input v-model="editedNomPays" type="text" class="form-input" />
        </label>
      </div>
      <div class="form-actions">
        <button @click="savePays" class="btn-save">Enregistrer</button>
        <button @click="cancelEdit" class="btn-cancel">Annuler</button>
      </div>
    </div>
  </div>
</template>
