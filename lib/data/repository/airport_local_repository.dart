import '../barrel.dart';

class AirportLocalRepositoryImpl extends AirPortRepository{
  final DatabaseHelper _databaseHelper;

  AirportLocalRepositoryImpl(this._databaseHelper);

  @override
  Future<List<Airport>> getAirportsFromLocal() async{
    final db = await _databaseHelper.database;
    final airportsData = await db.query('airports');
    final airports = airportsData.map((json) => Airport.fromJson(json)).toList();
    return airports;
  }
}