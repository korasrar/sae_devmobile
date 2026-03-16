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

  async updateVille(ville, newNomVille) {
    await fetch(this.apiEndpoint + 'villes/' + ville.id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ id_ville: ville.id, nom_ville: newNomVille, id_pays: ville.id_pays })
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
}
