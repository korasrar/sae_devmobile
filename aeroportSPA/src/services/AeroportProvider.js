export class AeroportProvider {
  constructor(apiEndpoint) {
    this.apiEndpoint = apiEndpoint;
  }

  async getAeroports() {
    const response = await fetch(this.apiEndpoint + 'aeroports');
    return await response.json();
  }

  async getVols() {
    const response = await fetch(this.apiEndpoint + 'vols');
    return await response.json();
  }

  async getCompagnies() {
    const response = await fetch(this.apiEndpoint + 'compagnies');
    return await response.json();
  }

  async getVilles() {
    const response = await fetch(this.apiEndpoint + 'villes');
    return await response.json();
  }

  async deleteVille(id) {
    await fetch(this.apiEndpoint + 'villes/' + id, {
      method: 'DELETE'
    });
  }

  async updateVille(ville, newNomVille, newIdPays) {
    await fetch(this.apiEndpoint + 'villes/' + ville.id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ id_ville: ville.id, nom_ville: newNomVille, id_pays: newIdPays || ville.id_pays })
    });
  }

  async getPays() {
    const response = await fetch(this.apiEndpoint + 'pays');
    return await response.json();
  }

  async deletePays(id) {
    await fetch(this.apiEndpoint + 'pays/' + id, {
      method: 'DELETE'
    });
  }

  async updatePays(pays, newNomPays) {
    await fetch(this.apiEndpoint + 'pays/' + pays.id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      // envoyer l'id pays en int
      body: JSON.stringify({ id_pays: parseInt(pays.id), nom_pays: newNomPays })
    });
  }

  async deleteCompagnie(id) {
    await fetch(this.apiEndpoint + 'compagnies/' + id, {
      method: 'DELETE'
    });
  }

  async updateCompagnie(compagnie, newNom, newIdPays) {
    await fetch(this.apiEndpoint + 'compagnies/' + compagnie.id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ id_compagnie: compagnie.id, nom: newNom, id_pays: newIdPays || compagnie.id_pays })
    });
  }

  async addAeroport(nomAeroport, idVille) {
    await fetch(this.apiEndpoint + 'aeroports', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ nom_aeroport: nomAeroport, id_ville: idVille })
    });
  }

  async deleteAeroport(id) {
    await fetch(this.apiEndpoint + 'aeroports/' + id, {
      method: 'DELETE'
    });
  }

  async updateAeroport(aeroport, newNomAeroport, newIdVille) {
    await fetch(this.apiEndpoint + 'aeroports/' + aeroport.id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ id_aeroport: aeroport.id, nom_aeroport: newNomAeroport, id_ville: newIdVille || aeroport.id_ville })
    });
  }
}
