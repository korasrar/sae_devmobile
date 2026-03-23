from flask import request, jsonify
from .app import app
from .models import *



# =====================
# PAYS
# =====================

@app.route("/api/pays", methods=["GET"])
def get_pays():
    pays = get_all_pays()
    return jsonify([p.to_json() for p in pays])


@app.route("/api/pays/<int:id>", methods=["GET"])
def get_pays_id(id):
    pays = get_pays_by_id(id)
    if pays:
        return jsonify(pays.to_json())
    return jsonify({"error": "Pays not found"}), 404


@app.route("/api/pays", methods=["POST"])
def create_new_pays():
    data = request.json
    pays = create_pays(data["id_pays"], data["nom_pays"])
    return jsonify(pays.to_json())


@app.route("/api/pays/<int:id>", methods=["PUT"])
def update_pays_route(id):
    data = request.json
    pays = update_pays(id, data["nom_pays"])
    return jsonify(pays.to_json())


@app.route("/api/pays/<int:id>", methods=["DELETE"])
def delete_pays_route(id):
    delete_pays(id)
    return jsonify({"message": "Pays deleted"})


# =====================
# VILLE
# =====================

@app.route("/api/villes", methods=["GET"])
def get_villes():
    villes = get_all_villes()
    return jsonify([v.to_json() for v in villes])


@app.route("/api/villes/<int:id>", methods=["GET"])
def get_ville_id(id):
    ville = get_ville_by_id(id)
    if ville:
        return jsonify(ville.to_json())
    return jsonify({"error": "Ville not found"}), 404


@app.route("/api/villes", methods=["POST"])
def create_new_ville():
    data = request.json
    ville = create_ville(
        data["id_ville"],
        data["nom_ville"],
        data["id_pays"]
    )
    return jsonify(ville.to_json())


@app.route("/api/villes/<int:id>", methods=["PUT"])
def update_ville_route(id):
    data = request.json
    ville = update_ville(id, data["nom_ville"])
    return jsonify(ville.to_json())


@app.route("/api/villes/<int:id>", methods=["DELETE"])
def delete_ville_route(id):
    delete_ville(id)
    return jsonify({"message": "Ville deleted"})


# =====================
# AEROPORT
# =====================

@app.route("/api/aeroports", methods=["GET"])
def get_aeroports():
    aeroports = get_all_aeroports()
    return jsonify([a.to_json() for a in aeroports])


@app.route("/api/aeroports/<int:id>", methods=["GET"])
def get_aeroport_id(id):
    aeroport = get_aeroport_by_id(id)
    if aeroport:
        return jsonify(aeroport.to_json())
    return jsonify({"error": "Aeroport not found"}), 404


@app.route("/api/aeroports", methods=["POST"])
def create_new_aeroport():
    data = request.json
    aeroport = create_aeroport(
        data["id_aeroport"],
        data["nom_aeroport"],
        data["id_ville"]
    )
    return jsonify(aeroport.to_json())


@app.route("/api/aeroports/<int:id>", methods=["PUT"])
def update_aeroport_route(id):
    data = request.json
    aeroport = update_aeroport(id, data["nom_aeroport"])
    return jsonify(aeroport.to_json())


@app.route("/api/aeroports/<int:id>", methods=["DELETE"])
def delete_aeroport_route(id):
    delete_aeroport(id)
    return jsonify({"message": "Aeroport deleted"})


# =====================
# COMPAGNIE
# =====================

@app.route("/api/compagnies", methods=["GET"])
def get_compagnies():
    compagnies = get_all_compagnies()
    return jsonify([c.to_json() for c in compagnies])


@app.route("/api/compagnies/<int:id>", methods=["GET"])
def get_compagnie_id(id):
    comp = get_compagnie_by_id(id)
    if comp:
        return jsonify(comp.to_json())
    return jsonify({"error": "Compagnie not found"}), 404


@app.route("/api/compagnies", methods=["POST"])
def create_new_compagnie():
    data = request.json
    comp = create_compagnie(
        data["id_compagnie"],
        data["nom"],
        data["id_pays"]
    )
    return jsonify(comp.to_json())


@app.route("/api/compagnies/<int:id>", methods=["PUT"])
def update_compagnie_route(id):
    data = request.json
    comp = update_compagnie(id, data["nom"])
    return jsonify(comp.to_json())


@app.route("/api/compagnies/<int:id>", methods=["DELETE"])
def delete_compagnie_route(id):
    delete_compagnie(id)
    return jsonify({"message": "Compagnie deleted"})


# =====================
# VOL
# =====================

@app.route("/api/vols", methods=["GET"])
def get_vols():
    vols = get_all_vols()
    return jsonify([v.to_json() for v in vols])


@app.route("/api/vols", methods=["POST"])
def create_new_vol():
    data = request.json

    vol = create_vol(
        data["num_vol"],
        data["id_compagnie"],
        data["date_depart"],
        data["date_arrive"],
        data["id_aeroport_depart"],
        data["terminal_depart"],
        data["id_aeroport_arrive"],
        data["terminal_arrive"]
    )

    return jsonify(vol.to_json())


@app.route("/api/vols", methods=["PUT"])
def update_vol_route():
    data = request.json

    vol = update_vol(
        data["num_vol"],
        data["id_compagnie"],
        data["date_depart"],
        data["date_arrive"],
        data["terminal_depart"],
        data["terminal_arrive"]
    )

    return jsonify(vol.to_json())


@app.route("/api/vols", methods=["DELETE"])
def delete_vol_route():
    data = request.json

    delete_vol(
        data["num_vol"],
        data["id_compagnie"],
        data["date_depart"]
    )

    return jsonify({"message": "Vol deleted"})


#===========requetes==============

@app.route("/api/villes/<ville>/destinations", methods=["GET"])
def destinations_from_city(ville):

    villes = get_destinations_from_city(ville)

    return jsonify({"destinations": villes})

@app.route("/api/destinations/<ville>/1-escale", methods=["GET"])
def destinations_1_escale(ville):
    return jsonify({"destinations": get_destinations_with_one_stop(ville)})


@app.route("/api/destinations/<ville>/2-escales", methods=["GET"])
def destinations_2_escales(ville):
    return jsonify({"destinations": get_destinations_with_two_stops(ville)})


@app.route("/api/destinations/<ville>/toutes", methods=["GET"])
def destinations_recursive(ville):
    return jsonify(get_accessible_cities(ville))