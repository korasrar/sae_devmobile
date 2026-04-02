SELECT
    VILLE.nom_ville
FROM
    VOL
    JOIN AEROPORT ON VOL.id_aeroport_arrive = AEROPORT.id_aeroport
    JOIN VILLE ON AEROPORT.id_ville = VILLE.id_ville
    JOIN AEROPORT A2 ON VOL.id_aeroport_depart = A2.id_aeroport
    JOIN VILLE V2 ON A2.id_ville = V2.id_ville
WHERE
    V2.nom_ville = 'Paris';