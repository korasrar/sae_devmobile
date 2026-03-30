SELECT DISTINCT v_dest.nom_ville
FROM VOL v1
JOIN VOL v2 ON v1.id_aeroport_arrive = v2.id_aeroport_depart AND v1.date_arrive < v2.date_depart
JOIN VOL v3 ON v2.id_aeroport_arrive = v3.id_aeroport_depart AND v2.date_arrive < v3.date_depart
JOIN AEROPORT a_paris ON v1.id_aeroport_depart = a_paris.id_aeroport
JOIN VILLE v_paris ON a_paris.id_ville = v_paris.id_ville
JOIN AEROPORT a_dest ON v3.id_aeroport_arrive = a_dest.id_aeroport
JOIN VILLE v_dest ON a_dest.id_ville = v_dest.id_ville
WHERE v_paris.nom_ville = 'Paris';