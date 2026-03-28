import pytest
import random
from todo.app import app, db
from todo.models import (
    create_pays, get_pays_by_id, update_pays, delete_pays,
    create_ville, get_ville_by_id, update_ville, delete_ville,
    create_aeroport, get_aeroport_by_id, update_aeroport, delete_aeroport,
    create_compagnie, get_compagnie_by_id, update_compagnie, delete_compagnie,
    create_vol, get_vol, update_vol, delete_vol
)
import datetime

@pytest.fixture(autouse=True)
def setup_and_teardown_db():
    with app.app_context():
        db.drop_all()
        db.create_all()
    yield
    with app.app_context():
        db.session.remove()
        db.drop_all()

def test_pays_model():
    with app.app_context():
        pays_id = random.randint(10000, 99999)
        pays = create_pays(pays_id, f"Testland{pays_id}")
        assert pays.id_pays == pays_id
        assert pays.nom_pays == f"Testland{pays_id}"
        fetched = get_pays_by_id(pays_id)
        assert fetched is not None
        assert fetched.nom_pays == f"Testland{pays_id}"
        updated = update_pays(pays_id, f"Testlandia{pays_id}")
        assert updated.nom_pays == f"Testlandia{pays_id}"
        delete_pays(pays_id)
        assert get_pays_by_id(pays_id) is None

def test_ville_model():
    with app.app_context():
        pays_id = random.randint(10000, 99999)
        ville_id = pays_id + 1
        create_pays(pays_id, f"Villeland{pays_id}")
        ville = create_ville(ville_id, f"VilleTest{ville_id}", pays_id)
        assert ville.id_ville == ville_id
        assert ville.nom_ville == f"VilleTest{ville_id}"
        fetched = get_ville_by_id(ville_id)
        assert fetched is not None
        assert fetched.nom_ville == f"VilleTest{ville_id}"
        from todo.models import update_ville
        updated = update_ville(ville_id, f"VilleTest2{ville_id}")
        assert updated.nom_ville == f"VilleTest2{ville_id}"
        delete_ville(ville_id)
        assert get_ville_by_id(ville_id) is None
        delete_pays(pays_id)

def test_aeroport_model():
    with app.app_context():
        pays_id = random.randint(10000, 99999)
        ville_id = pays_id + 1
        aeroport_id = pays_id + 2
        create_pays(pays_id, f"AeroLand{pays_id}")
        create_ville(ville_id, f"AeroVille{ville_id}", pays_id)
        aeroport = create_aeroport(aeroport_id, f"AeroTest{aeroport_id}", ville_id)
        assert aeroport.id_aeroport == aeroport_id
        assert aeroport.nom_aeroport == f"AeroTest{aeroport_id}"
        fetched = get_aeroport_by_id(aeroport_id)
        assert fetched is not None
        assert fetched.nom_aeroport == f"AeroTest{aeroport_id}"
        updated = update_aeroport(aeroport_id, f"AeroTest2{aeroport_id}")
        assert updated.nom_aeroport == f"AeroTest2{aeroport_id}"
        delete_aeroport(aeroport_id)
        assert get_aeroport_by_id(aeroport_id) is None
        delete_ville(ville_id)
        delete_pays(pays_id)

def test_compagnie_model():
    with app.app_context():
        pays_id = random.randint(10000, 99999)
        compagnie_id = pays_id + 1
        create_pays(pays_id, f"CompLand{pays_id}")
        comp = create_compagnie(compagnie_id, f"CompTest{compagnie_id}", pays_id)
        assert comp.id_compagnie == compagnie_id
        assert comp.nom == f"CompTest{compagnie_id}"
        fetched = get_compagnie_by_id(compagnie_id)
        assert fetched is not None
        assert fetched.nom == f"CompTest{compagnie_id}"
        updated = update_compagnie(compagnie_id, f"CompTest2{compagnie_id}")
        assert updated.nom == f"CompTest2{compagnie_id}"
        delete_compagnie(compagnie_id)
        assert get_compagnie_by_id(compagnie_id) is None
        delete_pays(pays_id)

def test_vol_model():
    with app.app_context():
        base = random.randint(10000, 99999)
        pays_id = base
        ville1_id = base + 1
        ville2_id = base + 2
        aeroport1_id = base + 3
        aeroport2_id = base + 4
        compagnie_id = base + 5
        num_vol = base + 6
        create_pays(pays_id, f"VolLand{base}")
        create_ville(ville1_id, f"VolVille1{base}", pays_id)
        create_ville(ville2_id, f"VolVille2{base}", pays_id)
        create_aeroport(aeroport1_id, f"VolAero1{base}", ville1_id)
        create_aeroport(aeroport2_id, f"VolAero2{base}", ville2_id)
        create_compagnie(compagnie_id, f"VolComp{base}", pays_id)
        date_depart = datetime.date(2026, 1, 1)
        date_arrive = datetime.date(2026, 1, 2)
        vol = create_vol(num_vol, compagnie_id, date_depart, date_arrive, aeroport1_id, "A", aeroport2_id, "B")
        assert vol.num_vol == num_vol
        assert vol.id_compagnie == compagnie_id
        fetched = get_vol(num_vol, compagnie_id, date_depart)
        assert fetched is not None
        assert fetched.num_vol == num_vol
        updated = update_vol(num_vol, compagnie_id, date_depart, date_arrive, "A2", "B2")
        assert updated.terminal_arrive == "B2"
        delete_vol(num_vol, compagnie_id, date_depart)
        assert get_vol(num_vol, compagnie_id, date_depart) is None
        delete_compagnie(compagnie_id)
        delete_aeroport(aeroport1_id)
        delete_aeroport(aeroport2_id)
        delete_ville(ville1_id)
        delete_ville(ville2_id)
        delete_pays(pays_id)
