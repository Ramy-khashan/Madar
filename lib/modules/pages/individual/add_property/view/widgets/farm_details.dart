import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_text_field.dart';
import 'detail_multi_chips.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class FarmDetails extends StatelessWidget {
  const FarmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.farmDetails),
        DetailTextField(
          label: AppStrings.builtArea,
          detailKey: DetailKeys.builtArea,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        DetailDropdown(
          label: AppStrings.soilType,
          detailKey: DetailKeys.soilType,
          options: AddPropertyBloc.soilTypeOptions,
        ),
        DetailMultiChips(
          label: AppStrings.waterSourceAvailability,
          detailKey: DetailKeys.waterSources,
          options: AddPropertyBloc.waterSourceOptions,
        ),
        SizedBox(height: 16.height),
        LabeledCounterPair(
          firstLabel: AppStrings.numberOfWells,
          firstKey: DetailKeys.wellsCount,
          secondLabel: AppStrings.numberOfPalmTrees,
          secondKey: DetailKeys.palmTreesCount,
        ),
        DetailTextField(
          label: AppStrings.wellDepth,
          detailKey: DetailKeys.wellDepth,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        DetailMultiChips(
          label: AppStrings.features,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.farmFacilityOptions,
        ),
        DetailTextField(
          label: AppStrings.distanceFromCity,
          detailKey: DetailKeys.distanceToCity,
          isNumeric: true,
          unit: 'km',
        ),
        const FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}
