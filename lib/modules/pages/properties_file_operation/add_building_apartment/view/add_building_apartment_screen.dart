import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/add_building_apartment_bloc.dart';
import 'add_building_apartment_view.dart';

class AddBuildingApartmentScreen extends StatelessWidget {
  const AddBuildingApartmentScreen({
    super.key,
    required this.buildingId,
    this.buildingName = '',
  });

  final String buildingId;
  final String buildingName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBuildingApartmentBloc(buildingId: buildingId),
      child: AddBuildingApartmentView(buildingName: buildingName),
    );
  }
}
