<script setup>
import { ref } from "vue";

const props = defineProps({
  vol: Object,
  aeroports: Array,
  compagnies: Array,
});

const emit = defineEmits(["delete", "update"]);

const isEditing = ref(false);
const editedDateDepart = ref("");
const editedDateArrive = ref("");
const editedterminalDepart = ref("");
const editedterminalArrive = ref("");
const editedIdAeroportDepart = ref(null);
const editedIdAeroportArrive = ref(null);
const editedIdCompagnie = ref("");

function deleteVol() {
  // emit delete avec l'id de la ville
  emit("delete", props.vol.id);
}

function startEdit() {
  isEditing.value = true;
  editedDateDepart.value = props.vol.date_depart;
  editedDateArrive.value = props.vol.date_arrive;
  editedterminalDepart.value = props.vol.terminal_depart;
  editedterminalArrive.value = props.vol.terminal_arrive;
  editedIdAeroportDepart.value = props.vol.id_aeroport_depart;
  editedIdAeroportArrive.value = props.vol.id_aeroport_arrive;
  editedIdCompagnie.value = props.vol.id_compagnie;
}

function cancelEdit() {
  isEditing.value = false;
}

function saveVol() {
  emit("update", {
    vol: props.vol,
    newDateDepart: editedDateDepart.value,
    newDateArrive: editedDateArrive.value,
    newterminalDepart: editedterminalDepart.value,
    newterminalArrive: editedterminalArrive.value,
    newIdAeroportDepart: editedIdAeroportDepart.value,
    newIdAeroportArrive: editedIdAeroportArrive.value,
    newIdCompagnie: editedIdCompagnie.value,
  });
  isEditing.value = false;
}
</script>

<template>
  <div class="item-card">
    <!-- si on édite pas ( etat de base ) -->
    <div v-if="!isEditing" class="item-display">
      <div class="item-info flight-card">
        <h3 class="item-name">Vol n° {{ vol.num_vol }} - {{ compagnies?.find((c) => c.id == vol.id_compagnie)?.nom || vol.id_compagnie }}</h3>
        
        <div class="flight-route">
          <div class="flight-side text-center">
            <i class="fa-solid fa-plane-departure flight-icon text-blue"></i>
            <h4 class="airport-name">{{ aeroports?.find((a) => a.id == vol.id_aeroport_depart)?.nom_aeroport || vol.id_aeroport_depart }}</h4>
            <div class="terminal-info">Terminal {{ vol.terminal_depart }}</div>
            <div class="date-info">{{ vol.date_depart }}</div>
          </div>
          
          <div class="flight-divider">
            <i class="fa-solid fa-plane flight-path-icon"></i>
            <div class="dotted-line"></div>
          </div>

          <div class="flight-side text-center">
            <i class="fa-solid fa-plane-arrival flight-icon text-green"></i>
            <h4 class="airport-name">{{ aeroports?.find((a) => a.id == vol.id_aeroport_arrive)?.nom_aeroport || vol.id_aeroport_arrive }}</h4>
            <div class="terminal-info">Terminal {{ vol.terminal_arrive }}</div>
            <div class="date-info">{{ vol.date_arrive }}</div>
          </div>
        </div>

      </div>
      <div class="item-actions">
        <button @click="startEdit" class="btn-edit">Modifier</button>
        <button @click="deleteVol" class="btn-delete">Supprimer</button>
      </div>
    </div>

    <!-- formulaire d'édition -->
    <div v-else class="item-form" @keyup.enter="saveVol">
      <h3 class="form-title">Modifier le vol</h3>

      <div class="form-group">
        <label class="form-label">
          Date de départ:
          <input v-model="editedDateDepart" type="text" class="form-input" />
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Terminal de départ:
          <input
            v-model="editedterminalDepart"
            type="text"
            class="form-input"
          />
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Aéroport de départ:
          <select v-model="editedIdAeroportDepart" class="form-select">
            <option :value="null">-- Sélectionner un aéroport --</option>
            <option v-for="a in aeroports" :key="a.id" :value="a.id">
              {{ a.nom_aeroport }}
            </option>
          </select>
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Date d'arrivée:
          <input v-model="editedDateArrive" type="text" class="form-input" />
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Terminal d'arrivée:
          <input
            v-model="editedterminalArrive"
            type="text"
            class="form-input"
          />
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Aéroport d'arrivée:
          <select v-model="editedIdAeroportArrive" class="form-select">
            <option :value="null">-- Sélectionner un aéroport --</option>
            <option v-for="a in aeroports" :key="a.id" :value="a.id">
              {{ a.nom_aeroport }}
            </option>
          </select>
        </label>
      </div>

      <div class="form-group">
        <label class="form-label">
          Compagnie:
          <select v-model="editedIdCompagnie" class="form-select">
            <option :value="null">-- Sélectionner une compagnie --</option>
            <option v-for="c in compagnies" :key="c.id" :value="c.id">
              {{ c.nom }}
            </option>
          </select>
        </label>
      </div>

      <div class="form-actions">
        <button @click="saveVol" class="btn-save">Enregistrer</button>
        <button @click="cancelEdit" class="btn-cancel">Annuler</button>
      </div>
    </div>
  </div>
</template>