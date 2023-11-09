import '../barrel.dart';
import 'base_client.dart';

class NetworkService {

  final BaseClient _client;

  // Private constructor
  NetworkService._(this._client);

  // Singleton instance
  static final NetworkService _singleton = NetworkService._(BaseClient());

  // Factory method to get the singleton instance
  factory NetworkService() {
    return _singleton;
  }

  Future<List<Airport>> getAirports() async {
    Map<String, dynamic> response =
          await _client.get(api: "/mwgg/Airports/master/airports.json");
    List<Airport> airports = response.entries.map((entry) => Airport.fromJson(entry.value)).toList();
    return airports;
  }
}
