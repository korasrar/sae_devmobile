/*
Veuillez fournir la liste des villes accessibles depuis Paris, 
en tenant compte des horaires de vol, avec des vols directs 
ou un nombre quelconque de correspondances.
 */
WITH ACCESSIBLE (id_aeroport_arrivee, id_ville_arrivee, nom_ville_arrivee, date_arrive, nb_correspondances) AS (
    -- Anchor member : Vols directs depuis Paris
    SELECT 
        vol.id_aeroport_arrive,
        v_arr.id_ville,
        v_arr.nom_ville,
        vol.date_arrive,
        0
    FROM VOL vol
    JOIN AEROPORT a_dep ON vol.id_aeroport_depart = a_dep.id_aeroport
    JOIN VILLE v_dep ON a_dep.id_ville = v_dep.id_ville
    JOIN AEROPORT a_arr ON vol.id_aeroport_arrive = a_arr.id_aeroport
    JOIN VILLE v_arr ON a_arr.id_ville = v_arr.id_ville
    WHERE v_dep.nom_ville = 'Paris'
    UNION ALL
    -- Recursive member : Vols avec correspondances
    SELECT 
        vol.id_aeroport_arrive,
        v_arr.id_ville,
        v_arr.nom_ville,
        vol.date_arrive,
        acc.nb_correspondances + 1
    FROM ACCESSIBLE acc
    JOIN VOL vol ON vol.id_aeroport_depart = acc.id_aeroport_arrivee AND vol.date_depart > acc.date_arrive
    JOIN AEROPORT a_arr ON vol.id_aeroport_arrive = a_arr.id_aeroport
    JOIN VILLE v_arr ON a_arr.id_ville = v_arr.id_ville
    WHERE v_arr.nom_ville <> 'Paris'
)
-- https://oracle-base.com/articles/11g/recursive-subquery-factoring-11gr2#cyclic
-- usage de cycle pour éviter les boucles infinies
CYCLE id_aeroport_arrivee SET is_cycle TO 1 DEFAULT 0
SELECT nom_ville_arrivee AS ville_accessible, MIN(nb_correspondances) AS nb_correspondances
FROM ACCESSIBLE
WHERE nom_ville_arrivee <> 'Paris' AND is_cycle = 0
GROUP BY nom_ville_arrivee
ORDER BY ville_accessible;
