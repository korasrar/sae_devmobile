import pytest
import sys
import os
import random
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from todo.app import app

import sqlalchemy
from todo.app import db

# Réinitialise la base avant chaque test
@pytest.fixture(autouse=True)
def setup_and_teardown_db():
    with app.app_context():
        db.drop_all()
        db.create_all()
    yield
    # Optionnel : nettoyage après test
    with app.app_context():
        db.session.remove()
        db.drop_all()

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_pays(client):
    response = client.get('/api/pays')
    assert response.status_code == 200
    assert isinstance(response.json, list)

def test_get_villes(client):
    response = client.get('/api/villes')
    assert response.status_code == 200
    assert isinstance(response.json, list)

def test_get_aeroports(client):
    response = client.get('/api/aeroports')
    assert response.status_code == 200
    assert isinstance(response.json, list)

def test_get_compagnies(client):
    response = client.get('/api/compagnies')
    assert response.status_code == 200
    assert isinstance(response.json, list)

def test_get_vols(client):
    response = client.get('/api/vols')
    assert response.status_code == 200
    assert isinstance(response.json, list)

# =====================
# PAYS
# =====================
def test_crud_pays(client):
    pays_id = random.randint(10000, 99999)
    # Create
    data = {"id_pays": pays_id, "nom_pays": f"Testland{pays_id}"}
    response = client.post('/api/pays', json=data)
    assert response.status_code == 200
    assert response.json["nom_pays"] == f"Testland{pays_id}"

    # Read
    response = client.get(f'/api/pays/{pays_id}')
    assert response.status_code == 200
    assert response.json["nom_pays"] == f"Testland{pays_id}"

    # Update
    response = client.put(f'/api/pays/{pays_id}', json={"nom_pays": f"Testlandia{pays_id}"})
    assert response.status_code == 200
    assert response.json["nom_pays"] == f"Testlandia{pays_id}"

    # Delete
    response = client.delete(f'/api/pays/{pays_id}')
    assert response.status_code == 200
    assert response.json["message"] == "Pays deleted"

# =====================
# VILLE
# =====================
def test_crud_ville(client):
    pays_id = random.randint(10000, 99999)
    ville_id = pays_id + 1
    # Crée d'abord un pays pour la clé étrangère
    client.post('/api/pays', json={"id_pays": pays_id, "nom_pays": f"Villeland{pays_id}"})
    data = {"id_ville": ville_id, "nom_ville": f"VilleTest{ville_id}", "id_pays": pays_id}
    response = client.post('/api/villes', json=data)
    assert response.status_code == 200
    assert response.json["nom_ville"] == f"VilleTest{ville_id}"

    # Read
    response = client.get(f'/api/villes/{ville_id}')
    assert response.status_code == 200
    assert response.json["nom_ville"] == f"VilleTest{ville_id}"

    # Update
    response = client.put(f'/api/villes/{ville_id}', json={"nom_ville": f"VilleTest2{ville_id}"})
    assert response.status_code == 200
    assert response.json["nom_ville"] == f"VilleTest2{ville_id}"

    # Delete
    response = client.delete(f'/api/villes/{ville_id}')
    assert response.status_code == 200
    assert response.json["message"] == "Ville deleted"
    # Nettoyage pays
    client.delete(f'/api/pays/{pays_id}')

# =====================
# AEROPORT
# =====================
def test_crud_aeroport(client):
    pays_id = random.randint(10000, 99999)
    ville_id = pays_id + 1
    aeroport_id = pays_id + 2
    # Crée d'abord un pays et une ville pour la clé étrangère
    client.post('/api/pays', json={"id_pays": pays_id, "nom_pays": f"AeroLand{pays_id}"})
    client.post('/api/villes', json={"id_ville": ville_id, "nom_ville": f"AeroVille{ville_id}", "id_pays": pays_id})
    data = {"id_aeroport": aeroport_id, "nom_aeroport": f"AeroTest{aeroport_id}", "id_ville": ville_id}
    response = client.post('/api/aeroports', json=data)
    assert response.status_code == 200
    assert response.json["nom_aeroport"] == f"AeroTest{aeroport_id}"

    # Read
    response = client.get(f'/api/aeroports/{aeroport_id}')
    assert response.status_code == 200
    assert response.json["nom_aeroport"] == f"AeroTest{aeroport_id}"

    # Update
    response = client.put(f'/api/aeroports/{aeroport_id}', json={"nom_aeroport": f"AeroTest2{aeroport_id}"})
    assert response.status_code == 200
    assert response.json["nom_aeroport"] == f"AeroTest2{aeroport_id}"

    # Delete
    response = client.delete(f'/api/aeroports/{aeroport_id}')
    assert response.status_code == 200
    assert response.json["message"] == "Aeroport deleted"
    # Nettoyage ville/pays
    client.delete(f'/api/villes/{ville_id}')
    client.delete(f'/api/pays/{pays_id}')

# =====================
# COMPAGNIE
# =====================
def test_crud_compagnie(client):
    pays_id = random.randint(10000, 99999)
    compagnie_id = pays_id + 1
    # Crée d'abord un pays pour la clé étrangère
    client.post('/api/pays', json={"id_pays": pays_id, "nom_pays": f"CompLand{pays_id}"})
    data = {"id_compagnie": compagnie_id, "nom": f"CompTest{compagnie_id}", "id_pays": pays_id}
    response = client.post('/api/compagnies', json=data)
    assert response.status_code == 200
    assert response.json["nom"] == f"CompTest{compagnie_id}"

    # Read
    response = client.get(f'/api/compagnies/{compagnie_id}')
    assert response.status_code == 200
    assert response.json["nom"] == f"CompTest{compagnie_id}"

    # Update
    response = client.put(f'/api/compagnies/{compagnie_id}', json={"nom": f"CompTest2{compagnie_id}"})
    assert response.status_code == 200
    assert response.json["nom"] == f"CompTest2{compagnie_id}"

    # Delete
    response = client.delete(f'/api/compagnies/{compagnie_id}')
    assert response.status_code == 200
    assert response.json["message"] == "Compagnie deleted"
    # Nettoyage pays
    client.delete(f'/api/pays/{pays_id}')

# =====================
# VOL
# =====================
def test_crud_vol(client):
    # Préparation : pays, villes, aeroports, compagnie
    client.post('/api/pays', json={"id_pays": 995, "nom_pays": "VolLand"})
    client.post('/api/villes', json={"id_ville": 666, "nom_ville": "VolVille1", "id_pays": 995})
    client.post('/api/villes', json={"id_ville": 667, "nom_ville": "VolVille2", "id_pays": 995})
    client.post('/api/aeroports', json={"id_aeroport": 333, "nom_aeroport": "VolAero1", "id_ville": 666})
    client.post('/api/aeroports', json={"id_aeroport": 334, "nom_aeroport": "VolAero2", "id_ville": 667})
    client.post('/api/compagnies', json={"id_compagnie": 222, "nom": "VolComp", "id_pays": 995})
    import datetime
    import random
    base = random.randint(10000, 99999)
    pays_id = base
    ville1_id = base + 1
    ville2_id = base + 2
    aeroport1_id = base + 3
    aeroport2_id = base + 4
    compagnie_id = base + 5
    num_vol = base + 6

    client.post('/api/pays', json={"id_pays": pays_id, "nom_pays": f"VolLand{base}"})
    client.post('/api/villes', json={"id_ville": ville1_id, "nom_ville": f"VolVille1{base}", "id_pays": pays_id})
    client.post('/api/villes', json={"id_ville": ville2_id, "nom_ville": f"VolVille2{base}", "id_pays": pays_id})
    client.post('/api/aeroports', json={"id_aeroport": aeroport1_id, "nom_aeroport": f"VolAero1{base}", "id_ville": ville1_id})
    client.post('/api/aeroports', json={"id_aeroport": aeroport2_id, "nom_aeroport": f"VolAero2{base}", "id_ville": ville2_id})
    client.post('/api/compagnies', json={"id_compagnie": compagnie_id, "nom": f"VolComp{base}", "id_pays": pays_id})
    data = {
        "num_vol": num_vol,
        "id_compagnie": compagnie_id,
        "date_depart": datetime.date(2026, 1, 1).isoformat(),
        "date_arrive": datetime.date(2026, 1, 1).isoformat(),
        "id_aeroport_depart": aeroport1_id,
        "terminal_depart": "A",
        "id_aeroport_arrive": aeroport2_id,
        "terminal_arrive": "B"
    }
    response = client.post('/api/vols', json=data)
    assert response.status_code == 200
    assert response.json["num_vol"] == num_vol

    # Update
    update_data = {
        "num_vol": num_vol,
        "id_compagnie": compagnie_id,
        "date_depart": datetime.date(2026, 1, 1).isoformat(),
        "date_arrive": datetime.date(2026, 1, 2).isoformat(),
        "terminal_depart": "A2",
        "terminal_arrive": "B2"
    }
    response = client.put('/api/vols', json=update_data)
    assert response.status_code == 200
    assert response.json["terminal_arrive"] == "B2"

    # Delete
    del_data = {
        "num_vol": num_vol,
        "id_compagnie": compagnie_id,
        "date_depart": datetime.date(2026, 1, 1).isoformat()
    }
    response = client.delete('/api/vols', json=del_data)
    assert response.status_code == 200
    assert response.json["message"] == "Vol deleted"
    # Nettoyage
    client.delete(f'/api/compagnies/{compagnie_id}')
    client.delete(f'/api/aeroports/{aeroport1_id}')
    client.delete(f'/api/aeroports/{aeroport2_id}')
    client.delete(f'/api/villes/{ville1_id}')
    client.delete(f'/api/villes/{ville2_id}')
    client.delete(f'/api/pays/{pays_id}')

# =====================
# REQUETES SPECIALES
# =====================
def test_special_routes(client):
    # On suppose qu'il existe au moins une ville dans la base
    response = client.get('/api/villes')
    villes = response.json
    if villes:
        ville_nom = villes[0]["nom_ville"]
        r1 = client.get(f'/api/villes/{ville_nom}/destinations')
        assert r1.status_code == 200
        r2 = client.get(f'/api/destinations/{ville_nom}/1-escale')
        assert r2.status_code == 200
        r3 = client.get(f'/api/destinations/{ville_nom}/2-escales')
        assert r3.status_code == 200
        r4 = client.get(f'/api/destinations/{ville_nom}/toutes')
        assert r4.status_code == 200
