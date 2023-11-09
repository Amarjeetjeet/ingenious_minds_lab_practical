import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/barrel.dart';
import 'widgets/barrel.dart';

class AirportDetails extends StatefulWidget {
  const AirportDetails({super.key, required this.airport});

  final Airport airport;

  @override
  State<AirportDetails> createState() => _AirportDetailsState();
}

class _AirportDetailsState extends State<AirportDetails> {
  late final LatLng _lanLong;

  @override
  void initState() {
    _lanLong = LatLng(widget.airport.lat, widget.airport.lon);
    super.initState();
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Airport detail"),
      ),
      body: Column(
        children: [mapView(), airportContent()],
      ),
    );
  }

  Padding airportContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableRowText(
            firstText: widget.airport.name,
            secondText: widget.airport.icao,
          ),
          Text("${widget.airport.city},${widget.airport.state}"),
          Text(widget.airport.country),
          Text(widget.airport.tz),
        ],
      ),
    );
  }

  Expanded mapView() {
    return Expanded(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lanLong,
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.airport.name),
            position: _lanLong,
          )
        },
      ),
    );
  }
}
