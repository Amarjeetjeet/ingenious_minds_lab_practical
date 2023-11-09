import 'package:flutter/material.dart';

import 'data/local_service/database_helper.dart';
import 'data/network_service/network_service.dart';
import 'feature/airport/airport_ui.dart';
import 'feature/airport/cubit/airport_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ingenious Minds lab practical',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AirportCubit(
          DatabaseHelper.instance,
          NetworkService(),
        )..loadAirport(),
        child: const AirportUi(),
      ),
    );
  }
}
