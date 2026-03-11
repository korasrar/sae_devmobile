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

  async getPays() {
    const response = await fetch(this.apiEndpoint + 'pays');
    return await response.json();
  }
}
