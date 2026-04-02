# Modèle Graphe

## Explications

## Entités

- Pays
- Ville
- Aeroport
- Terminal
- Comapgnie
- Vol

## Relations

- (Ville)-[:SITUE_DANS]->(Pays): localisation géographique
- (Aeroport)-[:SITUE_DANS]->(Ville): localisation d'aéroport
- (Terminal)-[:APPARTIENT_A]->(Aeroport): organisation aéroportuaire
- (Vol)-[:OPERE_PAR]->(Compagnie): opérateur du vol
- (Vol)-[:DEPART_DE]->(Terminal): point de départ
- (Vol)-[:ARRIVE_A]->(Terminal): point d'arrivée

## Données

Il faut aller dans le fichier `graphe.ex.md`, Copier coller le code cypher dans votre executeru Neo4j
