CREATE TABLE PAYS (
    id_pays INT,
    nom_pays VARCHAR2(25),
    CONSTRAINT pk_pays PRIMARY KEY (id_pays)
);

CREATE TABLE VILLE (
    id_ville INT,
    nom_ville VARCHAR2(25),
    id_pays INT,
    CONSTRAINT pk_ville PRIMARY KEY (id_ville)
);

CREATE TABLE AEROPORT (
    id_aeroport INT,
    nom_aeroport VARCHAR2(25) UNIQUE,
    id_ville INT,
    CONSTRAINT pk_aeroport PRIMARY KEY (id_aeroport)
);

CREATE TABLE COMPAGNIE (
    id_compagnie INT,
    nom VARCHAR2(20),
    id_pays INT,
    CONSTRAINT pk_compagnie PRIMARY KEY (id_compagnie)
);

CREATE TABLE VOL (
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

ALTER TABLE AEROPORT
ADD CONSTRAINT fk_aeroport_ville
FOREIGN KEY (id_ville) REFERENCES VILLE(id_ville);

ALTER TABLE VILLE
ADD CONSTRAINT fk_ville_pays
FOREIGN KEY (id_pays) REFERENCES PAYS(id_pays);

ALTER TABLE COMPAGNIE
ADD CONSTRAINT fk_compagnie_pays
FOREIGN KEY (id_pays) REFERENCES PAYS(id_pays);

ALTER TABLE VOL
ADD CONSTRAINT fk_vol_compagnie
FOREIGN KEY (id_compagnie) REFERENCES COMPAGNIE(id_compagnie);

ALTER TABLE VOL
ADD CONSTRAINT fk_vol_aeroport_depart
FOREIGN KEY (id_aeroport_depart) REFERENCES AEROPORT(id_aeroport);

ALTER TABLE VOL
ADD CONSTRAINT fk_vol_aeroport_arrive
FOREIGN KEY (id_aeroport_arrive) REFERENCES AEROPORT(id_aeroport);
