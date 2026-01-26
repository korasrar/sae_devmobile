create table PAYS(
    id_pays int,
    nom_pays varchar(25),
    primary key(id_pays)
)

create table VILLE(
    id_ville int,
    nom_ville varchar(25),
    id_pays int ,
    primary key(id_pays)
)


create table AEROPORT(
    id_aeroport int,
    nom_aeroport varchar(25) unique,
    id_ville int,
    primary key (id_aeroport)
)

create table COMPAGNIE(
    id_compagnie int,
    nom varchar(20),
    id_pays varchar(25),
    primary key(id_compagnie)
);


create table VOL(
    num_vol int,
    id_compagnie int,
    date_depart date,
    date_arrive date,

    id_aeroport_depart int ,
    terminal_depart int,

    id_aeroport_arrive int,
    terminal_arrive int,

    primary key(num_vol, id_compagnie, date_depart)
);

alter table AEROPORT add foreign key(id_ville) references VILLE(id_ville);
alter table VILLE add foreign key(id_pays) references PAYS(id_pays);
alter table COMPAGNIE add foreign key(id_pays) references PAYS(id_pays);

alter table VOL add foreign key(id_compagnie) references COMPAGNIE(id_compagnie);
alter table VOL add foreign key(id_aeroport_depart) references AEROPORT(id_aeroport);
alter table VOL add foreign key(id_aeroport_arrive) references AEROPORT(id_aeroport);