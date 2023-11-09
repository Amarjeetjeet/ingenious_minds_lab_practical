import 'package:flutter/material.dart';

import '../../../data/model/airport_response.dart';
import '../airport_details.dart';
import 'expandable_row_text.dart';

class AirportCardList extends StatelessWidget {
  const AirportCardList({
    super.key, required this.airports,
  });

  final List<Airport> airports;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: airports.length,
      itemBuilder: (context, index) {
        return Card(
          margin:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AirportDetails(airport: airports[index]),
                ),
              );
            },
            title: ExpandableRowText(
              firstText: airports[index].name,
              secondText: airports[index].icao,
            ),
            subtitle: ExpandableRowText(
              firstText:
              '${airports[index].city},${airports[index].state}',
              secondText: airports[index].country,
            ),
          ),
        );
      },
    );
  }
}
