import '../barrel.dart';

class AirportRepositoryImpl extends AirPortRepository{
  final NetworkService networkService;

  AirportRepositoryImpl(this.networkService);

  @override
  Future<List<Airport>> getAirportsFromLocal() async{
    return await networkService.getAirports();
  }
}