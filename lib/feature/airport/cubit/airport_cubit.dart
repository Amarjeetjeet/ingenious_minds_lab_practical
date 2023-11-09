export 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/barrel.dart';


part 'airport_state.dart';

class AirportCubit extends Cubit<AirportState> {
  AirportCubit(this._databaseHelper, this.networkService)
      : super(AirportLoading());
  final NetworkService networkService;
  final DatabaseHelper _databaseHelper;

  Future<void> _loadAirportsFromRemote(AirPortRepository airPortRepository) async {
    emit(AirportLoading());
    try {
      List<Airport> airports = await airPortRepository.getAirportsFromLocal();
      _saveAirportsToDatabase(airports);
      emit(AirportSuccess(airports));
    } catch (e) {
      emit(AirportFailed(e.toString()));
    }
  }

  Future<void> _saveAirportsToDatabase(List<Airport> airports) async {
    final db = await _databaseHelper.database;
    for (var airport in airports) {
      await db.insert('airports', airport.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> _loadAirportsFromDatabase(AirPortRepository airPortRepository) async {
    emit(AirportLoading());
    try {
      List<Airport> airports = await airPortRepository.getAirportsFromLocal();
      emit(AirportSuccess(airports));
    } catch (e) {
      emit(const AirportFailed("Failed to load data from the database"));
    }
  }

  Future<void> loadAirport() async {
    AirPortRepository airPortRepository =
        AirportLocalRepositoryImpl(_databaseHelper);
    List<Airport> airports = await airPortRepository.getAirportsFromLocal();

    if(airports.isEmpty){
      await _loadAirportsFromRemote(AirportRepositoryImpl(networkService));
    }else{
      await _loadAirportsFromDatabase(AirportLocalRepositoryImpl(_databaseHelper));
    }
  }
}

