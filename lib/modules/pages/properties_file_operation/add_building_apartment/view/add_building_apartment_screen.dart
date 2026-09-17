import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/add_building_apartment_bloc.dart';
import 'add_building_apartment_view.dart';

class AddBuildingApartmentScreen extends StatelessWidget {
  const AddBuildingApartmentScreen({
    super.key,
    required this.buildingId,
    this.buildingName = '',
    this.isShop = false,
  });

  final String buildingId;
  final String buildingName;
  final bool isShop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBuildingApartmentBloc(
        buildingId: buildingId,
        isShop: isShop,
      ),
      child: AddBuildingApartmentView(buildingName: buildingName),
    );
  }
}
