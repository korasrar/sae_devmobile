CREATE 
// Compagnies
(airFrance:Compagnie {nom: 'Air France', code: 'AF'}),
(germanEagle:Compagnie {nom: 'German Eagle', code: 'GER'}),
(abelagAviation:Compagnie {nom: 'Abelag Aviation', code: 'AAB'}),
(airChina:Compagnie {nom: 'Air China', code: 'CCA'}),

// Pays
(france:Pays {nom: 'France'}),
(allemagne:Pays {nom: 'Allemagne'}),
(usa:Pays {nom: 'USA'}),

// Villes
(paris:Ville {nom: 'Paris', pays: 'France'}),
(berlin:Ville {nom: 'Berlin', pays: 'Allemagne'}),
(newYork:Ville {nom: 'New York', pays: 'USA'}),

// Terminaux
(terminal2CDG:Terminal {nom: '2', aeroport: 'CDG'}),
(terminal1BER:Terminal {nom: '1', aeroport: 'BER'}),
(terminal4JFK:Terminal {nom: '4', aeroport: 'JFK'}),

// Aéroports
(cdg:Aeroport {code: 'CDG', nom: 'Charles de Gaulle'}),
(ber:Aeroport {code: 'BER', nom: 'Willy Brandt'}),
(jfk:Aeroport {code: 'JFK', nom: 'John F. Kennedy'}),

// Vols
(vol:Vol {
  numero: 'AF006',
  dateDepart: date('2026-04-15'),
  heureDepart: time('10:30'),
  dateArrivee: date('2026-04-15'),
  heureArrivee: time('13:45')
}),
(vol2:Vol {
  numero: 'AF007',
  dateDepart: date('2026-04-16'),
  heureDepart: time('18:30'),
  dateArrivee: date('2026-04-17'),
  heureArrivee: time('08:00')
}),
(vol3:Vol {
  numero: 'GER001',
  dateDepart: date('2026-04-20'),
  heureDepart: time('09:00'),
  dateArrivee: date('2026-04-20'),
  heureArrivee: time('10:45')
}),

// Relations Villes -> Pays
(paris)-[:SITUE_DANS]->(france),
(berlin)-[:SITUE_DANS]->(allemagne),
(newYork)-[:SITUE_DANS]->(usa),

// Relations Terminaux -> Aéroports
(terminal2CDG)-[:APPARTIENT_A]->(cdg),
(terminal1BER)-[:APPARTIENT_A]->(ber),
(terminal4JFK)-[:APPARTIENT_A]->(jfk),

// Relations Aéroports -> Villes
(cdg)-[:SITUE_DANS]->(paris),
(ber)-[:SITUE_DANS]->(berlin),
(jfk)-[:SITUE_DANS]->(newYork),

// Relations Vols -> Compagnie
(vol)-[:OPERE_PAR]->(airFrance),
(vol2)-[:OPERE_PAR]->(airFrance),
(vol3)-[:OPERE_PAR]->(germanEagle),

// Relations Vols -> Terminaux
(vol)-[:DEPART_DE]->(terminal2CDG),
(vol)-[:ARRIVE_A]->(terminal4JFK),
(vol2)-[:DEPART_DE]->(terminal4JFK),
(vol2)-[:ARRIVE_A]->(terminal2CDG),
(vol3)-[:DEPART_DE]->(terminal1BER),
(vol3)-[:ARRIVE_A]->(terminal2CDG);
