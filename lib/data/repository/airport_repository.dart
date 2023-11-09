import '../barrel.dart';

abstract class AirPortRepository{
  Future<List<Airport>> getAirportsFromLocal();
}
