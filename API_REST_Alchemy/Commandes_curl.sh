# ================= PAYS =================
# GET
curl -i http://localhost:5000/api/pays
curl -i http://localhost:5000/api/pays/1

# POST
curl -i -H "Content-Type: application/json" \
-X POST \
-d '{"id_pays":100,"nom_pays":"Canada"}' \
http://localhost:5000/api/pays

# PUT
curl -i -H "Content-Type: application/json" \
-X PUT \
-d '{"nom_pays":"Canada Modifie"}' \
http://localhost:5000/api/pays/16

# DELETE
curl -i -X DELETE http://localhost:5000/api/pays/16



# ================= VILLE =================
# GET
curl -i http://localhost:5000/api/villes
curl -i http://localhost:5000/api/villes/1

# POST
curl -i -H "Content-Type: application/json" \
-X POST \
-d '{"id_ville":20,"nom_ville":"Toronto","id_pays":1}' \
http://localhost:5000/api/villes

# PUT
curl -i -H "Content-Type: application/json" \
-X PUT \
-d '{"nom_ville":"Toronto Centre"}' \
http://localhost:5000/api/villes/20

# DELETE
curl -i -X DELETE http://localhost:5000/api/villes/20



# ================= AEROPORT =================
# GET
curl -i http://localhost:5000/api/aeroports
curl -i http://localhost:5000/api/aeroports/1

# POST
curl -i -H "Content-Type: application/json" \
-X POST \
-d '{"id_aeroport":20,"nom_aeroport":"Toronto Pearson","id_ville":1}' \
http://localhost:5000/api/aeroports

# PUT
curl -i -H "Content-Type: application/json" \
-X PUT \
-d '{"nom_aeroport":"Pearson International"}' \
http://localhost:5000/api/aeroports/20

# DELETE
curl -i -X DELETE http://localhost:5000/api/aeroports/20



# ================= COMPAGNIE =================
# GET
curl -i http://localhost:5000/api/compagnies
curl -i http://localhost:5000/api/compagnies/1

# POST
curl -i -H "Content-Type: application/json" \
-X POST \
-d '{"id_compagnie":20,"nom":"Air Canada","id_pays":1}' \
http://localhost:5000/api/compagnies

# PUT
curl -i -H "Content-Type: application/json" \
-X PUT \
-d '{"nom":"Air Canada Express"}' \
http://localhost:5000/api/compagnies/20

# DELETE
curl -i -X DELETE http://localhost:5000/api/compagnies/20



# ================= VOL =================
# GET
curl -i http://localhost:5000/api/vols

# POST
curl -i -H "Content-Type: application/json" \
-X POST \
-d '{
"num_vol":2000,
"id_compagnie":1,
"date_depart":"2026-06-01T10:00:00",
"date_arrive":"2026-06-01T12:00:00",
"id_aeroport_depart":1,
"terminal_depart":2,
"id_aeroport_arrive":3,
"terminal_arrive":1
}' \
http://localhost:5000/api/vols

# PUT
curl -i -H "Content-Type: application/json" \
-X PUT \
-d '{
"num_vol":2000,
"id_compagnie":1,
"date_depart":"2026-06-01T10:00:00",
"date_arrive":"2026-06-01T13:00:00",
"terminal_depart":3,
"terminal_arrive":2
}' \
http://localhost:5000/api/vols

# DELETE
curl -i -H "Content-Type: application/json" \
-X DELETE \
-d '{
"num_vol":2000,
"id_compagnie":1,
"date_depart":"2026-06-01T10:00:00"
}' \
http://localhost:5000/api/vols