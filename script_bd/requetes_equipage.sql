
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
