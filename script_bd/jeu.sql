-- Insertion des PAYS
INSERT INTO PAYS (id_pays, nom_pays) VALUES (1, 'France');
INSERT INTO PAYS (id_pays, nom_pays) VALUES (2, 'Espagne');
INSERT INTO PAYS (id_pays, nom_pays) VALUES (3, 'Italie');
INSERT INTO PAYS (id_pays, nom_pays) VALUES (4, 'Royaume-Uni');
INSERT INTO PAYS (id_pays, nom_pays) VALUES (5, 'Allemagne');

-- Insertion des VILLES
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (1, 'Paris', 1);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (2, 'Lyon', 1);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (3, 'Madrid', 2);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (4, 'Barcelone', 2);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (5, 'Rome', 3);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (6, 'Milan', 3);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (7, 'Londres', 4);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (8, 'Berlin', 5);
INSERT INTO VILLE (id_ville, nom_ville, id_pays) VALUES (9, 'Munich', 5);

-- Insertion des AEROPORTS
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (1, 'Charles de Gaulle', 1);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (2, 'Orly', 1);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (3, 'Lyon-Saint Exupery', 2);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (4, 'Madrid-Barajas', 3);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (5, 'Barcelona-El Prat', 4);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (6, 'Fiumicino', 5);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (7, 'Malpensa', 6);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (8, 'Heathrow', 7);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (9, 'Berlin-Brandenburg', 8);
INSERT INTO AEROPORT (id_aeroport, nom_aeroport, id_ville) VALUES (10, 'Munich', 9);

-- Insertion des COMPAGNIES
INSERT INTO COMPAGNIE (id_compagnie, nom, id_pays) VALUES (1, 'Air France', 1);
INSERT INTO COMPAGNIE (id_compagnie, nom, id_pays) VALUES (2, 'Iberia', 2);
INSERT INTO COMPAGNIE (id_compagnie, nom, id_pays) VALUES (3, 'Alitalia', 3);
INSERT INTO COMPAGNIE (id_compagnie, nom, id_pays) VALUES (4, 'British Airways', 4);
INSERT INTO COMPAGNIE (id_compagnie, nom, id_pays) VALUES (5, 'Lufthansa', 5);

-- Insertion des VOLS
-- Vol Air France: Paris CDG (Terminal 2) vers Madrid-Barajas (Terminal 1) - 15/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (101, 1, TO_DATE('2026-02-15 08:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 10:30', 'YYYY-MM-DD HH24:MI'), 1, 2, 4, 1);

-- Vol Air France: Paris CDG (Terminal 2) vers Londres Heathrow (Terminal 3) - 15/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (102, 1, TO_DATE('2026-02-15 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 15:30', 'YYYY-MM-DD HH24:MI'), 1, 2, 8, 3);

-- Vol Iberia: Madrid-Barajas (Terminal 1) vers Paris CDG (Terminal 2) - 16/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (201, 2, TO_DATE('2026-02-16 09:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-16 11:00', 'YYYY-MM-DD HH24:MI'), 4, 1, 1, 2);

-- Vol Iberia: Barcelone El Prat (Terminal 2) vers Rome Fiumicino (Terminal 3) - 16/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (202, 2, TO_DATE('2026-02-16 16:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-16 18:30', 'YYYY-MM-DD HH24:MI'), 5, 2, 6, 3);

-- Vol Alitalia: Rome Fiumicino (Terminal 3) vers Paris CDG (Terminal 2) - 17/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (301, 3, TO_DATE('2026-02-17 07:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-17 09:00', 'YYYY-MM-DD HH24:MI'), 6, 3, 1, 2);

-- Vol Alitalia: Milan Malpensa (Terminal 1) vers Berlin-Brandenburg (Terminal 1) - 17/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (302, 3, TO_DATE('2026-02-17 12:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-17 13:15', 'YYYY-MM-DD HH24:MI'), 7, 1, 9, 1);

-- Vol British Airways: Londres Heathrow (Terminal 5) vers Paris CDG (Terminal 2) - 18/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (401, 4, TO_DATE('2026-02-18 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-18 11:15', 'YYYY-MM-DD HH24:MI'), 8, 5, 1, 2);

-- Vol British Airways: Londres Heathrow (Terminal 3) vers Madrid-Barajas (Terminal 2) - 18/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (402, 4, TO_DATE('2026-02-18 15:45', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-18 18:30', 'YYYY-MM-DD HH24:MI'), 8, 3, 4, 2);

-- Vol Lufthansa: Berlin-Brandenburg (Terminal 1) vers Paris CDG (Terminal 1) - 19/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (501, 5, TO_DATE('2026-02-19 08:15', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-19 09:30', 'YYYY-MM-DD HH24:MI'), 9, 1, 1, 1);

-- Vol Lufthansa: Munich (Terminal 2) vers Rome Fiumicino (Terminal 1) - 19/02/2026
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive) 
VALUES (502, 5, TO_DATE('2026-02-19 13:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-19 14:45', 'YYYY-MM-DD HH24:MI'), 10, 2, 6, 1);

-- ============================================================
-- Vols supplémentaires pour tester la requête récursive
-- ============================================================

-- Vol Air France: Paris CDG (Terminal 2) vers Lyon-Saint Exupéry (Terminal 1) - 15/02/2026
-- => Lyon accessible en 0 correspondance
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive)
VALUES (103, 1, TO_DATE('2026-02-15 09:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 10:00', 'YYYY-MM-DD HH24:MI'), 1, 2, 3, 1);

-- Vol Air France: Paris CDG (Terminal 2) vers Milan Malpensa (Terminal 1) - 16/02/2026
-- => Milan accessible en 0 correspondance
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive)
VALUES (104, 1, TO_DATE('2026-02-16 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-16 11:30', 'YYYY-MM-DD HH24:MI'), 1, 2, 7, 1);

-- Vol Iberia: Madrid-Barajas (Terminal 1) vers Barcelone El Prat (Terminal 2) - 15/02/2026
-- => Barcelone accessible en 1 correspondance : Paris->Madrid (vol 101, arrive 10:30) -> Barcelone (depart 12:00 > 10:30)
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive)
VALUES (203, 2, TO_DATE('2026-02-15 12:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 13:00', 'YYYY-MM-DD HH24:MI'), 4, 1, 5, 2);

-- Vol British Airways: Londres Heathrow (Terminal 3) vers Berlin-Brandenburg (Terminal 1) - 15/02/2026
-- => Berlin accessible en 1 correspondance : Paris->Londres (vol 102, arrive 15:30) -> Berlin (depart 17:00 > 15:30)
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive)
VALUES (403, 4, TO_DATE('2026-02-15 17:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 18:30', 'YYYY-MM-DD HH24:MI'), 8, 3, 9, 1);

-- Vol Lufthansa: Berlin-Brandenburg (Terminal 1) vers Munich (Terminal 2) - 15/02/2026
-- => Munich accessible en 2 correspondances : Paris->Londres->Berlin (arrive 18:30) -> Munich (depart 20:00 > 18:30)
INSERT INTO VOL (num_vol, id_compagnie, date_depart, date_arrive, id_aeroport_depart, terminal_depart, id_aeroport_arrive, terminal_arrive)
VALUES (504, 5, TO_DATE('2026-02-15 20:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2026-02-15 21:00', 'YYYY-MM-DD HH24:MI'), 9, 1, 10, 2);

-- Note : Rome accessible en 2 correspondances via le vol 202 existant :
-- Paris->Madrid (vol 101, arrive 10:30) -> Barcelone (vol 203, arrive 13:00) -> Rome (vol 202, depart 16/02 16:30 > 13:00)

COMMIT;
