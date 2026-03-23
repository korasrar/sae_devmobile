import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router";
import "./style.css";
import App from "./App.vue";
import HomeView from "./views/HomeView.vue";
import VillesView from "./views/VillesView.vue";
import PaysView from "./views/PaysView.vue";
import CompagniesView from "./views/CompagniesView.vue";
import AeroportsView from "./views/AeroportsView.vue";
import AeroportsAddView from "./views/AeroportsAddView.vue";

const routes = [
  { path: "/", redirect: "/home" },
  { path: "/home", component: HomeView },
  { path: "/villes", component: VillesView },
  { path: "/pays", component: PaysView },
  { path: "/compagnies", component: CompagniesView },
  { path: "/aeroports", component: AeroportsView },
  { path: "/aeroports/add", component: AeroportsAddView },
  { path: "/:pathMatch(.*)*", redirect: "/home" },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});

createApp(App).use(router).mount("#app");
