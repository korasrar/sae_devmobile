CREATE TABLE
    PAYS (
        id_pays INT,
        nom_pays VARCHAR2 (25),
        CONSTRAINT pk_pays PRIMARY KEY (id_pays)
    );

CREATE TABLE
    VILLE (
        id_ville INT,
        nom_ville VARCHAR2 (25),
        id_pays INT,
        CONSTRAINT pk_ville PRIMARY KEY (id_ville)
    );

CREATE TABLE
    AEROPORT (
        id_aeroport INT,
        nom_aeroport VARCHAR2 (25) UNIQUE,
        id_ville INT,
        CONSTRAINT pk_aeroport PRIMARY KEY (id_aeroport)
    );

CREATE TABLE
    COMPAGNIE (
        id_compagnie INT,
        nom VARCHAR2 (20),
        id_pays INT,
        CONSTRAINT pk_compagnie PRIMARY KEY (id_compagnie)
    );

CREATE TABLE
    VOL (
        num_vol INT,
        id_compagnie INT,
        date_depart DATE,
        date_arrive DATE,
        id_aeroport_depart INT,
        terminal_depart INT,
        id_aeroport_arrive INT,
        terminal_arrive INT,
        CONSTRAINT pk_vol PRIMARY KEY (num_vol, id_compagnie, date_depart)
    );

ALTER TABLE AEROPORT ADD CONSTRAINT fk_aeroport_ville FOREIGN KEY (id_ville) REFERENCES VILLE (id_ville);

ALTER TABLE VILLE ADD CONSTRAINT fk_ville_pays FOREIGN KEY (id_pays) REFERENCES PAYS (id_pays);

ALTER TABLE COMPAGNIE ADD CONSTRAINT fk_compagnie_pays FOREIGN KEY (id_pays) REFERENCES PAYS (id_pays);

ALTER TABLE VOL ADD CONSTRAINT fk_vol_compagnie FOREIGN KEY (id_compagnie) REFERENCES COMPAGNIE (id_compagnie);

ALTER TABLE VOL ADD CONSTRAINT fk_vol_aeroport_depart FOREIGN KEY (id_aeroport_depart) REFERENCES AEROPORT (id_aeroport);

ALTER TABLE VOL ADD CONSTRAINT fk_vol_aeroport_arrive FOREIGN KEY (id_aeroport_arrive) REFERENCES AEROPORT (id_aeroport);

/*
Veuillez fournir la liste des villes accessibles depuis Paris, 
en tenant compte des horaires de vol, avec des vols directs 
ou un nombre quelconque de correspondances.
*/
WITH RECURSIVE Vols_Paris AS (
    -- Anchor member : vols directs au départ de Paris
    SELECT 
        v.id_ville AS ville_arrivee,
        v.nom_ville AS nom_ville_arrivee,
        1 AS correspondances
    FROM VOL vol
    JOIN AEROPORT a ON vol.id_aeroport_depart = a.id_aeroport
    JOIN VILLE v ON a.id_ville = v.id_ville
    WHERE v.nom_ville = 'Paris'
    
    UNION ALL
    
    -- Recursive member : vols avec correspondances
    SELECT 
        v2.id_ville AS ville_arrivee,
        v2.nom_ville AS nom_ville_arrivee,
        vp.correspondances + 1 AS correspondances
    FROM Vols_Paris vp
    JOIN VOL vol ON vp.ville_arrivee = vol.id_aeroport_depart
    JOIN AEROPORT a ON vol.id_aeroport_arrive = a.id_aeroport
    JOIN VILLE v2 ON a.id_ville = v2.id_ville
)
SELECT DISTINCT nom_ville_arrivee, correspondances
FROM Vols_Paris
WHERE nom_ville_arrivee != 'Paris'
ORDER BY nom_ville_arrivee;