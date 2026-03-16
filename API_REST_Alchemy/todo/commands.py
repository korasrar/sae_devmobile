from .app import app, db
from .models import *

from datetime import datetime


@app.cli.command()
def syncdb():

    db.drop_all()
    db.create_all()

    # =====================
    # PAYS
    # =====================
    create_pays(1, 'France')
    create_pays(2, 'Espagne')
    create_pays(3, 'Allemagne')
    create_pays(4, 'Italie')
    create_pays(5, 'Belgique')
    create_pays(6, 'Portugal')
    create_pays(7, 'Pays-Bas')
    create_pays(8, 'Suisse')
    create_pays(9, 'Autriche')
    create_pays(10, 'Royaume-Uni')
    create_pays(11, 'Irlande')
    create_pays(12, 'Suede')
    create_pays(13, 'Norvege')
    create_pays(14, 'Danemark')
    create_pays(15, 'Pologne')

    # =====================
    # VILLES
    # =====================
    create_ville(1, 'Paris', 1)
    create_ville(2, 'Lyon', 1)
    create_ville(3, 'Marseille', 1)
    create_ville(4, 'Madrid', 2)
    create_ville(5, 'Barcelone', 2)
    create_ville(6, 'Berlin', 3)
    create_ville(7, 'Munich', 3)
    create_ville(8, 'Rome', 4)
    create_ville(9, 'Milan', 4)
    create_ville(10, 'Bruxelles', 5)
    create_ville(11, 'Lisbonne', 6)
    create_ville(12, 'Amsterdam', 7)
    create_ville(13, 'Zurich', 8)
    create_ville(14, 'Vienne', 9)
    create_ville(15, 'Londres', 10)

    # =====================
    # AEROPORTS
    # =====================
    create_aeroport(1, 'Charles de Gaulle', 1)
    create_aeroport(2, 'Orly', 1)
    create_aeroport(3, 'Lyon Saint-Exupery', 2)
    create_aeroport(4, 'Marseille Provence', 3)
    create_aeroport(5, 'Madrid Barajas', 4)
    create_aeroport(6, 'Barcelone El Prat', 5)
    create_aeroport(7, 'Berlin Brandenburg', 6)
    create_aeroport(8, 'Munich Franz Josef Strauss', 7)
    create_aeroport(9, 'Rome Fiumicino', 8)
    create_aeroport(10, 'Milan Malpensa', 9)
    create_aeroport(11, 'Bruxelles National', 10)
    create_aeroport(12, 'Lisbonne Humberto Delgado', 11)
    create_aeroport(13, 'Amsterdam Schiphol', 12)
    create_aeroport(14, 'Zurich Kloten', 13)
    create_aeroport(15, 'London Heathrow', 15)

    # =====================
    # COMPAGNIES
    # =====================
    create_compagnie(1, 'Air France', 1)
    create_compagnie(2, 'Iberia', 2)
    create_compagnie(3, 'Lufthansa', 3)
    create_compagnie(4, 'ITA Airways', 4)
    create_compagnie(5, 'Brussels Airlines', 5)
    create_compagnie(6, 'TAP Air Portugal', 6)
    create_compagnie(7, 'KLM', 7)
    create_compagnie(8, 'Swiss', 8)
    create_compagnie(9, 'Austrian Airlines', 9)
    create_compagnie(10, 'British Airways', 10)
    create_compagnie(11, 'Ryanair', 11)
    create_compagnie(12, 'SAS', 14)
    create_compagnie(13, 'Norwegian', 13)
    create_compagnie(14, 'Wizz Air', 15)
    create_compagnie(15, 'EasyJet', 10)

    # =====================
    # VOLS
    # =====================

    create_vol(1001, 1,
        datetime(2026,3,1,8,0),
        datetime(2026,3,1,9,10),
        1,2,3,1)

    create_vol(1002, 1,
        datetime(2026,3,1,14,0),
        datetime(2026,3,1,15,15),
        3,1,1,2)

    create_vol(1003, 2,
        datetime(2026,3,2,10,0),
        datetime(2026,3,2,12,0),
        5,1,1,3)

    create_vol(1004, 3,
        datetime(2026,3,2,9,30),
        datetime(2026,3,2,11,0),
        7,2,13,1)

    create_vol(1005, 4,
        datetime(2026,3,3,16,0),
        datetime(2026,3,3,18,10),
        9,1,10,2)

    create_vol(1006, 5,
        datetime(2026,3,4,7,45),
        datetime(2026,3,4,8,30),
        11,1,1,1)

    create_vol(1007, 6,
        datetime(2026,3,4,12,0),
        datetime(2026,3,4,14,30),
        12,2,15,3)

    create_vol(1008, 7,
        datetime(2026,3,5,6,0),
        datetime(2026,3,5,7,20),
        13,1,7,2)

    create_vol(1009, 8,
        datetime(2026,3,6,11,0),
        datetime(2026,3,6,12,10),
        14,1,1,2)

    create_vol(1010, 9,
        datetime(2026,3,7,15,30),
        datetime(2026,3,7,17,0),
        14,2,9,1)

    create_vol(1011, 10,
        datetime(2026,3,8,9,0),
        datetime(2026,3,8,11,30),
        15,3,1,2)

    create_vol(1012, 11,
        datetime(2026,3,9,13,0),
        datetime(2026,3,9,15,0),
        10,1,5,2)

    create_vol(1013, 12,
        datetime(2026,3,10,8,15),
        datetime(2026,3,10,10,0),
        15,2,12,1)

    create_vol(1014, 13,
        datetime(2026,3,11,17,0),
        datetime(2026,3,11,19,30),
        15,1,7,2)

    create_vol(1015, 14,
        datetime(2026,3,12,6,30),
        datetime(2026,3,12,8,45),
        3,2,11,1)

    print("Base de données synchronisée avec le fichier de peuplement.")