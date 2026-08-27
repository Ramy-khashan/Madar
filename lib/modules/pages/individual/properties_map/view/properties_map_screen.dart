import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/google_map_model.dart';
import '../controller/properties_map_bloc.dart';
import 'widgets/properties_map_view.dart';

class PropertiesMapScreen extends StatelessWidget {
  final PositionModel? initialPosition;
  const PropertiesMapScreen({super.key, this.initialPosition});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PropertiesMapBloc(initialPosition: initialPosition),
      child: const PropertiesMapView(),
    );
  }
}
