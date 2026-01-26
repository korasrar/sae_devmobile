# sae_devmobile

## Dépendances Fonctionnelle

- id_pays -> nom_pays
- id_ville -> nom_ville, #id_pays
- id_aeroport -> nom_aeroport, #id_ville
- id_compagnie -> nom_compagnie, #id_pays

- (id_compagnie, numero_vol,  dh_depart) -> #id_aeroport_depart, terminal_depart, #id_aeroport_arrivee, terminal_arrivee, dh_arrive
  - #id_ville -> #id_pays
  - #id_aeroport_depart -> #id_ville
  - #id_aeroport_arrivee -> #id_ville
