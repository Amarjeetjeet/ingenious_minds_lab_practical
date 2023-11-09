part of 'airport_cubit.dart';

sealed class AirportState extends Equatable {
  const AirportState();
}

class AirportLoading extends AirportState {
  @override
  List<Object> get props => [];
}

class AirportFailed extends AirportState {
  final String errorMessage;

  const AirportFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class AirportSuccess extends AirportState {
  final List<Airport> airports;

  const AirportSuccess(this.airports);
  @override
  List<Object> get props => [airports];
}