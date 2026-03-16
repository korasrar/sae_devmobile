<script setup>
const props = defineProps({
  ville: Object,
});

const emit = defineEmits(["delete", "update"]);

function deleteVille() {
  // emit delete avec l'id de la ville
  emit("delete", props.ville.id);
}

function updateVille() {
  // emit update avec la ville et le nouveau nom de la ville
  emit("update", {
    ville: props.ville,
    newNomVille: prompt("Modifier la ville", props.ville.nom_ville),
  });
}
</script>

<template>
  <div>
    <h3>{{ ville.nom_ville }}</h3>
    <button @click="deleteVille" value="Supprimer">Supprimer</button>
    <button @click="updateVille" value="Modifier">Modifier</button>
  </div>
</template>
