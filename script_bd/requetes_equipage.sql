
SELECT 
    v.NumVol,
    e.fonction,
    COUNT(*) as nombre_personnes
FROM VOL v,
     TABLE(v.Equipage) e
GROUP BY v.NumVol, e.fonction
ORDER BY v.NumVol, e.fonction;



SELECT 
    e.nom as pilote,
    COUNT(DISTINCT v.NumVol) as nombre_vols
FROM VOL v,
     TABLE(v.Equipage) e
WHERE e.fonction = 'Pilote'
GROUP BY e.nom
ORDER BY e.nom;


-- (c) Pour chaque vol, indiquer l'impact de chaque indice de qualité
-- L'impact = valeur * poid
SELECT 
    v.NumVol,
    i.Atype as indice_type,
    i.valeur,
    i.poid,
    (i.valeur * i.poid) as impact
FROM VOL v,
     TABLE(v.IndicesQualite) i
ORDER BY v.NumVol, i.Atype;


-- (d) Pour chaque indice de qualité, calculer son impact moyen
SELECT 
    i.Atype as indice_type,
    ROUND(AVG(i.valeur * i.poid), 2) as impact_moyen
FROM VOL v,
     TABLE(v.IndicesQualite) i
GROUP BY i.Atype
ORDER BY i.Atype;

