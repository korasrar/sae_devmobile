export class AeroportProvider {
  constructor(apiEndpoint) {
    this.apiEndpoint = apiEndpoint;
  }

  async getAeroports() {
    try {
      const response = await fetch(this.apiEndpoint + 'aeroports');
      const data = await response.json();
      return data.map(item => ({ ...item, id: item.id_aeroport }));
    } catch (error) {
      throw new Error('Erreur lors de la récupération des aéroports');
    }
  }

  async getVols() {
    try {
      const response = await fetch(this.apiEndpoint + 'vols');
      const data = await response.json();
      return data.map(item => ({ ...item, id: JSON.stringify({ num_vol: item.num_vol, id_compagnie: item.id_compagnie, date_depart: item.date_depart }) }));
    } catch (error) {
      throw new Error('Erreur lors de la récupération des vols');
    }
  }

  async getCompagnies() {
    try {
      const response = await fetch(this.apiEndpoint + 'compagnies');
      const data = await response.json();
      return data.map(item => ({ ...item, id: item.id_compagnie }));
    } catch (error) {
      throw new Error('Erreur lors de la récupération des compagnies');
    }
  }

  async getVilles() {
    try {
      const response = await fetch(this.apiEndpoint + 'villes');
      const data = await response.json();
      return data.map(item => ({ ...item, id: item.id_ville }));
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
        body: JSON.stringify({ nom_ville: newNomVille, id_pays: newIdPays })
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
        body: JSON.stringify({ id_ville: Math.floor(Math.random() * 1000000), nom_ville: nomVille, id_pays: idPays })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout de la ville');
    }
  }

  async getPays() {
    try {
      const response = await fetch(this.apiEndpoint + 'pays');
      const data = await response.json();
      return data.map(item => ({ ...item, id: item.id_pays }));
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
        body: JSON.stringify({ nom_pays: newNomPays })
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
        body: JSON.stringify({ id_pays: Math.floor(Math.random() * 1000000), nom_pays: nomPays })
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
        body: JSON.stringify({ id_compagnie: Math.floor(Math.random() * 1000000), nom: nomCompagnie, id_pays: idPays })
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
        body: JSON.stringify({ nom: newNom, id_pays: newIdPays })
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
        body: JSON.stringify({ id_aeroport: Math.floor(Math.random() * 1000000), nom_aeroport: nomAeroport, id_ville: idVille })
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
        body: JSON.stringify({ nom_aeroport: newNomAeroport, id_ville: newIdVille })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification de l\'aéroport');
    }
  }

  async addVol(numVol, idCompagnie, idAeroportDepart, idAeroportArrivee, dateDepart, dateArrivee, terminalDepart, terminalArrive) {
    try {
      await fetch(this.apiEndpoint + 'vols', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ num_vol: numVol, id_compagnie: idCompagnie, id_aeroport_depart: idAeroportDepart, id_aeroport_arrive: idAeroportArrivee, date_depart: dateDepart, date_arrive: dateArrivee, terminal_depart: terminalDepart, terminal_arrive: terminalArrive })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de l\'ajout du vol');
    }
  }

  async deleteVol(idString) {
    try {
      const volKeys = JSON.parse(idString);
      await fetch(this.apiEndpoint + 'vols', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(volKeys)
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la suppression du vol');
    }
  }

  async updateVol(vol, newDateDepart, newDateArrive, newterminalDepart, newterminalArrive, newIdAeroportDepart, newIdAeroportArrive, newCompagnie) {
    try {
      await fetch(this.apiEndpoint + 'vols', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          num_vol: vol.num_vol, 
          old_id_compagnie: vol.id_compagnie,
          old_date_depart: vol.date_depart,
          id_compagnie: newCompagnie || vol.id_compagnie, 
          id_aeroport_depart: newIdAeroportDepart || vol.id_aeroport_depart, 
          id_aeroport_arrive: newIdAeroportArrive || vol.id_aeroport_arrive, 
          date_depart: newDateDepart || vol.date_depart, 
          date_arrive: newDateArrive || vol.date_arrive, 
          terminal_depart: newterminalDepart !== undefined ? newterminalDepart : vol.terminal_depart,
          terminal_arrive: newterminalArrive !== undefined ? newterminalArrive : vol.terminal_arrive
        })
      });
      return { success: true };
    } catch (error) {
      throw new Error('Erreur lors de la modification du vol');
    }
  }
}
