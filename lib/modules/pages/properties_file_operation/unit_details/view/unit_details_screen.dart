import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../property_file/model/property_file_model.dart';
import '../controller/unit_details_bloc.dart';
import 'widgets/unit_details_content.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({
    super.key,
    required this.unit,
    required this.propertyName,
    this.buildingId = '',
  });

  final UnitModel unit;
  final String propertyName;
  final String buildingId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnitDetailsBloc()
        ..add(UnitDetailsInit(unit, buildingId: buildingId)),
      child: UnitDetailsContent(propertyName: propertyName),
    );
  }
}
