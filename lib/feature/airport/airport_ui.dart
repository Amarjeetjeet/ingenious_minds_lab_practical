import 'package:flutter/material.dart';

import 'cubit/airport_cubit.dart';
import 'widgets/barrel.dart';

class AirportUi extends StatelessWidget {
  const AirportUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airports'),
      ),
      body: BlocBuilder<AirportCubit, AirportState>(
        builder: (context, state) {
          return switch (state) {
            AirportLoading() => const ProgressBar(),
            AirportSuccess() => AirportCardList(airports: state.airports,),
            AirportFailed() => Center(child: Text(state.errorMessage)),
          };
        },
      ),
    );
  }
}

