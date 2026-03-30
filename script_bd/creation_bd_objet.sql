/*
NumVol AeroDep DateHeureDep AeroArr DateHeureArr  
AF442 CDG 2024.06.11 13 :00 GIG 2024.06.11 19 :00
Equipage
Nom Fonction
Goscinny Pilote
Uderzo Commissaire
IndicesQualite
[(carbone, 3, 4),
(securite, 4, 5 ), (prix, 4, 3))]
 */
create
or replace type equipageT as object (nom varchar2 (20), fonction varchar2 (20));

create type equipageTabT as table of equipageT;

create
or replace type indicesT as object (
    Atype varchar2 (20),
    valeur number (1),
    poid number (2)
);

create type indicesList as VARRAY (3) of indicesT;

create table
    VOL (
        NumVol varchar2 (20),
        AeroDep varchar2 (10),
        DateHeureDep date,
        AeroArr varchar2 (10),
        DateHeureArr date,
        Equipage equipageT,
        IndicesQualite indicesList
    ) nested table Equipage store as Equipage_nt;