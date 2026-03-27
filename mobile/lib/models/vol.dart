class Vol{
  int num_vol;
  int id_compagnie;
  String date_depart;
  String date_arrive;
  int id_aeroport_depart;
  int id_aeroport_arrive;
  int terminal_depart;
  int terminal_arrive;

  Vol({
    required this.num_vol,
    required this.id_compagnie,
    required this.date_depart,
    required this.date_arrive,
    required this.id_aeroport_depart,
    required this.id_aeroport_arrive,
    required this.terminal_depart,
    required this.terminal_arrive
  });

  Map<String, Object?> toMap() {
    return {'num_vol': num_vol,
            'id_compagnie': id_compagnie,
            'date_depart': date_depart,
            'date_arrive': date_arrive,
            'id_aeroport_depart': id_aeroport_depart,
            'id_aeroport_arrive': id_aeroport_arrive,
            'terminal_depart': terminal_depart,
            'terminal_arrive': terminal_arrive};
  }

  factory Vol.fromJson(Map<String, dynamic> json) {
    return Vol(
      num_vol: json['num_vol'],
      id_compagnie: json['id_compagnie'],
      date_depart: json['date_depart'],
      date_arrive: json['date_arrive'],
      id_aeroport_depart: json['id_aeroport_depart'],
      id_aeroport_arrive: json['id_aeroport_arrive'],
      terminal_depart: json['terminal_depart'],
      terminal_arrive: json['terminal_arrive']

    );
  }

  factory Vol.fromMap(Map<String, dynamic> map) {
    return Vol(
      num_vol: map['num_vol'],
      id_compagnie: map['id_compagnie'],
        date_depart: map['date_depart'],
      date_arrive: map['date_arrive'],
      id_aeroport_depart: map['id_aeroport_depart'],
      id_aeroport_arrive: map['id_aeroport_arrive'],
      terminal_depart: map['terminal_depart'],
      terminal_arrive: map['terminal_arrive']
    );
  }

}
