export class AeroportProvider {
  constructor(apiEndpoint) {
    this.apiEndpoint = apiEndpoint;
  }

  async getAeroports() {
    try {
      const response = await fetch(this.apiEndpoint + 'aeroports');
      return await response.json();
    } catch (error) {
      throw new Error('Erreur lors de la récupération des aéroports');
    }
  }

  async getVols() {
    try {
      const response = await fetch(this.apiEndpoint + 'vols');
      return await response.json();
    } catch (error) {
      throw new Error('Erreur lors de la récupération des vols');
    }
  }

  async getCompagnies() {
    try {
      const response = await fetch(this.apiEndpoint + 'compagnies');
      return await response.json();
    } catch (error) {
      throw new Error('Erreur lors de la récupération des compagnies');
    }
  }

  async getVilles() {
    try {
      const response = await fetch(this.apiEndpoint + 'villes');
      return await response.json();
    } catch (error) {
      throw new Error('Erreur lors de la récupération des villes');
    }
  }

  async deleteVille(id) {
    try {
      await fetch(this.apiEndpoint + 'villes/' + id, {
        method: 'DELETE'
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression de la ville');
    }
  }

  async updateVille(ville, newNomVille, newIdPays) {
    try {
      await fetch(this.apiEndpoint + 'villes/' + ville.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_ville: ville.id, nom_ville: newNomVille, id_pays: newIdPays || ville.id_pays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification de la ville');
    }
  }

  async addVille(nomVille, idPays) {
    try {
      await fetch(this.apiEndpoint + 'villes', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nom_ville: nomVille, id_pays: idPays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout de la ville');
    }
  }

  async getPays() {
    try {
      const response = await fetch(this.apiEndpoint + 'pays');
      return await response.json();
    } catch (error) {
      throw new Error('Erreur lors de la récupération des pays');
    }
  }

  async deletePays(id) {
    try {
      await fetch(this.apiEndpoint + 'pays/' + id, {
        method: 'DELETE'
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression du pays');
    }
  }

  async updatePays(pays, newNomPays) {
    try {
      await fetch(this.apiEndpoint + 'pays/' + pays.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        // envoyer l'id pays en int
        body: JSON.stringify({ id_pays: parseInt(pays.id), nom_pays: newNomPays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification du pays');
    }
  }

  async addPays(nomPays) {
    try {
      await fetch(this.apiEndpoint + 'pays', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nom_pays: nomPays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout du pays');
    }
  }

  async addCompagnie(nomCompagnie, idPays) {
    try {
      await fetch(this.apiEndpoint + 'compagnies', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nom: nomCompagnie, id_pays: idPays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout de la compagnie');
    }
  }

  async deleteCompagnie(id) {
    try {
      await fetch(this.apiEndpoint + 'compagnies/' + id, {
        method: 'DELETE'
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression de la compagnie');
    }
  }

  async updateCompagnie(compagnie, newNom, newIdPays) {
    try {
      await fetch(this.apiEndpoint + 'compagnies/' + compagnie.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_compagnie: compagnie.id, nom: newNom, id_pays: newIdPays || compagnie.id_pays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification de la compagnie');
    }
  }

  async addAeroport(nomAeroport, idVille) {
    try {
      await fetch(this.apiEndpoint + 'aeroports', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nom_aeroport: nomAeroport, id_ville: idVille })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout de l\'aéroport');
    }
  }

  async deleteAeroport(id) {
    try {
      await fetch(this.apiEndpoint + 'aeroports/' + id, {
        method: 'DELETE'
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression de l\'aéroport');
    }
  }

  async updateAeroport(aeroport, newNomAeroport, newIdVille) {
    try {
      await fetch(this.apiEndpoint + 'aeroports/' + aeroport.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_aeroport: aeroport.id, nom_aeroport: newNomAeroport, id_ville: newIdVille || aeroport.id_ville })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification de l\'aéroport');
    }
  }

  async addVol(idCompagnie, idAeroportDepart, idAeroportArrivee, dateDepart, dateArrivee, terminalDepart, terminalArrive) {
    try {
      await fetch(this.apiEndpoint + 'vols', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_compagnie: idCompagnie, id_aeroport_depart: idAeroportDepart, id_aeroport_arrive: idAeroportArrivee, date_depart: dateDepart, date_arrive: dateArrivee, terminal_depart: terminalDepart, terminal_arrive: terminalArrive })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout du vol');
    }
  }

  async deleteVol(id) {
    try {
      await fetch(this.apiEndpoint + 'vols/' + id, {
        method: 'DELETE'
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression du vol');
    }
  }

  async updateVol(vol, newDateDepart, newDateArrive, newterminalDepart, newterminalArrive, newIdAeroportDepart, newIdAeroportArrive, newCompagnie) {
    try {
      await fetch(this.apiEndpoint + 'vols/' + vol.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({num_vol: vol.num_vol, id_compagnie: newCompagnie, id_aeroport_depart: newIdAeroportDepart, id_aeroport_arrive: newIdAeroportArrive, date_depart: newDateDepart, date_arrive: newDateArrive, terminal_depart: newterminalDepart, terminal_arrive: newterminalArrive })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification du vol');
    }
  }
}
