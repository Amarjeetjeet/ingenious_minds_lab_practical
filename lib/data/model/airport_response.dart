class Airport {
  String icao;
  String iata;
  String name;
  String city;
  String state;
  String country;
  int elevation;
  double lat;
  double lon;
  String tz;

  Airport({
    required this.icao,
    this.iata = '',
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.elevation,
    required this.lat,
    required this.lon,
    required this.tz,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      icao: json['icao'],
      iata: json['iata'] ?? '',
      name: json['name'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      elevation: json['elevation'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tz: json['tz'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icao': icao,
      'iata': iata,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'elevation': elevation,
      'lat': lat,
      'lon': lon,
      'tz': tz,
    };
  }
}
