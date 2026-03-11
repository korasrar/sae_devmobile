<template>
  <header class="app-header">
    <h1 class="app-title">AeroportSPA</h1>
    <nav class="app-nav">
      <RouterLink to="/home">Home</RouterLink>
      <RouterLink to="/vols">Vols</RouterLink>
      <RouterLink to="/aeroports">Aéroports</RouterLink>
      <RouterLink to="/compagnies">Compagnies</RouterLink>
      <RouterLink to="/villes">Villes</RouterLink>
      <RouterLink to="/pays">Pays</RouterLink>
    </nav>
    <span class="app-route">{{ $route.fullPath }}</span>
  </header>
  <main>
    <RouterView />
  </main>
</template>
