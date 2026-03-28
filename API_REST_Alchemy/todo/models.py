from .app import db


# =====================
# PAYS
# =====================

class Pays(db.Model):
    __tablename__ = "PAYS"

    id_pays = db.Column(db.Integer, primary_key=True)
    nom_pays = db.Column(db.String(25))

    villes = db.relationship("Ville", backref=db.backref("Pays", lazy="select"), uselist=True)
    compagnies = db.relationship("Compagnie", backref=db.backref("Pays", lazy="select"), uselist=True)

    def __init__(self, id_pays, nom_pays):
        self.id_pays = id_pays
        self.nom_pays = nom_pays

    def __repr__(self):
        return f"{self.to_json()}"

    def to_json(self):
        return {
            "id_pays": self.id_pays,
            "nom_pays": self.nom_pays
        }


def create_pays(id_pays, nom_pays):
    new = Pays(id_pays, nom_pays)
    db.session.add(new)
    db.session.commit()
    return new


def get_pays_by_id(id_pays):
    return Pays.query.get(id_pays)


def get_all_pays():
    return Pays.query.all()


def update_pays(id_pays, new_nom):
    pays = Pays.query.get(id_pays)
    if pays:
        pays.nom_pays = new_nom
        db.session.commit()
    return pays


def delete_pays(id_pays):
    pays = Pays.query.get(id_pays)
    if pays:
        db.session.delete(pays)
        db.session.commit()


# =====================
# VILLE
# =====================

class Ville(db.Model):
    __tablename__ = "VILLE"

    id_ville = db.Column(db.Integer, primary_key=True)
    nom_ville = db.Column(db.String(25))
    id_pays = db.Column(db.Integer, db.ForeignKey("PAYS.id_pays"))

    aeroports = db.relationship("Aeroport", backref=db.backref("Ville", lazy="select"), uselist=True)

    def __init__(self, id_ville, nom_ville, id_pays):
        self.id_ville = id_ville
        self.nom_ville = nom_ville
        self.id_pays = id_pays

    def __repr__(self):
        return f"{self.to_json()}"

    def to_json(self):
        return {
            "id_ville": self.id_ville,
            "nom_ville": self.nom_ville,
            "id_pays": self.id_pays
        }


def create_ville(id_ville, nom_ville, id_pays):
    new = Ville(id_ville, nom_ville, id_pays)
    db.session.add(new)
    db.session.commit()
    return new


def get_ville_by_id(id_ville):
    return Ville.query.get(id_ville)


def get_all_villes():
    return Ville.query.all()


def update_ville(id_ville, new_nom):
    ville = Ville.query.get(id_ville)
    if ville:
        ville.nom_ville = new_nom
        db.session.commit()
    return ville


def delete_ville(id_ville):
    ville = Ville.query.get(id_ville)
    if ville:
        db.session.delete(ville)
        db.session.commit()


# =====================
# AEROPORT
# =====================

class Aeroport(db.Model):
    __tablename__ = "AEROPORT"

    id_aeroport = db.Column(db.Integer, primary_key=True)
    nom_aeroport = db.Column(db.String(25), unique=True)
    id_ville = db.Column(db.Integer, db.ForeignKey("VILLE.id_ville"))

    def __init__(self, id_aeroport, nom_aeroport, id_ville):
        self.id_aeroport = id_aeroport
        self.nom_aeroport = nom_aeroport
        self.id_ville = id_ville

    def __repr__(self):
        return f"{self.to_json()}"

    def to_json(self):
        return {
            "id_aeroport": self.id_aeroport,
            "nom_aeroport": self.nom_aeroport,
            "id_ville": self.id_ville
        }


def create_aeroport(id_aeroport, nom_aeroport, id_ville):
    new = Aeroport(id_aeroport, nom_aeroport, id_ville)
    db.session.add(new)
    db.session.commit()
    return new


def get_aeroport_by_id(id_aeroport):
    return Aeroport.query.get(id_aeroport)


def get_all_aeroports():
    return Aeroport.query.all()


def update_aeroport(id_aeroport, new_nom):
    aeroport = Aeroport.query.get(id_aeroport)
    if aeroport:
        aeroport.nom_aeroport = new_nom
        db.session.commit()
    return aeroport


def delete_aeroport(id_aeroport):
    aeroport = Aeroport.query.get(id_aeroport)
    if aeroport:
        db.session.delete(aeroport)
        db.session.commit()


# =====================
# COMPAGNIE
# =====================

class Compagnie(db.Model):
    __tablename__ = "COMPAGNIE"

    id_compagnie = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(20))
    id_pays = db.Column(db.Integer, db.ForeignKey("PAYS.id_pays"))

    vols = db.relationship("Vol", backref=db.backref("Compagnie", lazy="select"), uselist=True)

    def __init__(self, id_compagnie, nom, id_pays):
        self.id_compagnie = id_compagnie
        self.nom = nom
        self.id_pays = id_pays

    def __repr__(self):
        return f"{self.to_json()}"

    def to_json(self):
        return {
            "id_compagnie": self.id_compagnie,
            "nom": self.nom,
            "id_pays": self.id_pays
        }



def create_compagnie(id_compagnie, nom, id_pays):
    new = Compagnie(id_compagnie, nom, id_pays)
    db.session.add(new)
    db.session.commit()
    return new


def get_compagnie_by_id(id_compagnie):
    return Compagnie.query.get(id_compagnie)


def get_all_compagnies():
    return Compagnie.query.all()


def update_compagnie(id_compagnie, new_nom):
    comp = Compagnie.query.get(id_compagnie)
    if comp:
        comp.nom = new_nom
        db.session.commit()
    return comp


def delete_compagnie(id_compagnie):
    comp = Compagnie.query.get(id_compagnie)
    if comp:
        db.session.delete(comp)
        db.session.commit()


# =====================
# VOL
# =====================

class Vol(db.Model):
    __tablename__ = "VOL"

    num_vol = db.Column(db.Integer, primary_key=True)
    id_compagnie = db.Column(db.Integer, db.ForeignKey("COMPAGNIE.id_compagnie"), primary_key=True)
    date_depart = db.Column(db.Date, primary_key=True)

    date_arrive = db.Column(db.Date)

    id_aeroport_depart = db.Column(db.Integer, db.ForeignKey("AEROPORT.id_aeroport"))
    terminal_depart = db.Column(db.Integer)

    id_aeroport_arrive = db.Column(db.Integer, db.ForeignKey("AEROPORT.id_aeroport"))
    terminal_arrive = db.Column(db.Integer)

    def __init__(self, num_vol, id_compagnie, date_depart, date_arrive,
                 id_aeroport_depart, terminal_depart,
                 id_aeroport_arrive, terminal_arrive):

        self.num_vol = num_vol
        self.id_compagnie = id_compagnie
        self.date_depart = date_depart
        self.date_arrive = date_arrive
        self.id_aeroport_depart = id_aeroport_depart
        self.terminal_depart = terminal_depart
        self.id_aeroport_arrive = id_aeroport_arrive
        self.terminal_arrive = terminal_arrive

    def __repr__(self):
        return f"{self.to_json()}"

    def to_json(self):
        return {
            "num_vol": self.num_vol,
            "id_compagnie": self.id_compagnie,
            "date_depart": str(self.date_depart),
            "date_arrive": str(self.date_arrive),
            "id_aeroport_depart": self.id_aeroport_depart,
            "terminal_depart": self.terminal_depart,
            "id_aeroport_arrive": self.id_aeroport_arrive,
            "terminal_arrive": self.terminal_arrive
        }




def create_vol(num_vol, id_compagnie, date_depart, date_arrive,
               id_aeroport_depart, terminal_depart,
               id_aeroport_arrive, terminal_arrive):

    new = Vol(num_vol, id_compagnie, date_depart, date_arrive,
              id_aeroport_depart, terminal_depart,
              id_aeroport_arrive, terminal_arrive)

    db.session.add(new)
    db.session.commit()
    return new


def get_vol(num_vol, id_compagnie, date_depart):
    return Vol.query.get((num_vol, id_compagnie, date_depart))


def get_all_vols():
    return Vol.query.all()


def update_vol(num_vol, id_compagnie, date_depart,
               new_date_arrive, new_terminal_depart, new_terminal_arrive):

    vol = Vol.query.get((num_vol, id_compagnie, date_depart))

    if vol:
        vol.date_arrive = new_date_arrive
        vol.terminal_depart = new_terminal_depart
        vol.terminal_arrive = new_terminal_arrive
        db.session.commit()

    return vol


def delete_vol(num_vol, id_compagnie, date_depart):
    vol = Vol.query.get((num_vol, id_compagnie, date_depart))

    if vol:
        db.session.delete(vol)
        db.session.commit()