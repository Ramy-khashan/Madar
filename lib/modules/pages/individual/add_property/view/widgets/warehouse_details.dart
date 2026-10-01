import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_counter.dart';
import 'detail_text_field.dart';
import 'detail_bool_radio.dart';
import 'furnishing_and_condition.dart';

class WarehouseDetails extends StatelessWidget {
  const WarehouseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.warehouseDetails),
        DetailTextField(
          label: AppStrings.internalHeight,
          detailKey: DetailKeys.height,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        SizedBox(height: 16.height),
        DetailBoolRadio(
          label: AppStrings.administrativeOffices,
          detailKey: DetailKeys.hasOffice,
        ),
        SizedBox(height: 16.height),
        DetailBoolRadio(
          label: AppStrings.externalYardForLoading,
          detailKey: DetailKeys.hasYard,
        ),
        DetailTextField(
          label: AppStrings.yardSize,
          detailKey: DetailKeys.yardArea,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        DetailTextField(
          label: AppStrings.electricityCapacity,
          detailKey: DetailKeys.electricityKW,
          isNumeric: true,
          unit: 'KW',
        ),
        DetailCounter(
          label: AppStrings.numberOfDoors,
          detailKey: DetailKeys.doorsCount,
        ),
        DetailDropdown(
          label: AppStrings.doorType,
          detailKey: DetailKeys.doorType,
          options: AddPropertyBloc.doorTypeOptions,
        ),
        DetailDropdown(
          label: AppStrings.cooling,
          detailKey: DetailKeys.coolingType,
          options: AddPropertyBloc.coolingOptions,
        ),
        DetailDropdown(
          label: AppStrings.flooring,
          detailKey: DetailKeys.floorType,
          options: AddPropertyBloc.flooringOptions,
        ),
        const FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}
