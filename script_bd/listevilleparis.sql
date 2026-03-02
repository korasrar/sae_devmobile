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
WITH ACCESSIBLE (id_aeroport_arrivee, id_ville_arrivee, nom_ville_arrivee, date_arrive, nb_correspondances) AS (
    SELECT
        vol.id_aeroport_arrive,
        v_arr.id_ville,
        v_arr.nom_ville,
        vol.date_arrive,
        0
    FROM VOL vol,
         AEROPORT a_dep,
         VILLE    v_dep,
         AEROPORT a_arr,
         VILLE    v_arr
    WHERE vol.id_aeroport_depart = a_dep.id_aeroport
      AND a_dep.id_ville         = v_dep.id_ville
      AND v_dep.nom_ville        = 'Paris'
      AND vol.id_aeroport_arrive = a_arr.id_aeroport
      AND a_arr.id_ville         = v_arr.id_ville
    UNION ALL
    SELECT
        vol.id_aeroport_arrive,
        v_arr.id_ville,
        v_arr.nom_ville,
        vol.date_arrive,
        acc.nb_correspondances + 1
    FROM ACCESSIBLE acc,
         VOL        vol,
         AEROPORT   a_arr,
         VILLE      v_arr
    WHERE vol.id_aeroport_depart = acc.id_aeroport_arrivee
      AND vol.date_depart        > acc.date_arrive
      AND vol.id_aeroport_arrive = a_arr.id_aeroport
      AND a_arr.id_ville         = v_arr.id_ville
) CYCLE id_ville_arrivee SET is_cycle TO '1' DEFAULT '0'
SELECT DISTINCT nom_ville_arrivee AS ville_accessible, nb_correspondances
FROM ACCESSIBLE
WHERE is_cycle        = '0'
  AND nom_ville_arrivee <> 'Paris'
ORDER BY ville_accessible, nb_correspondances;