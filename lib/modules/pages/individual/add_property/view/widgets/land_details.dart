import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_number_dropdown.dart';
import 'detail_text_field.dart';
import 'detail_multi_chips.dart';
import 'section_title.dart';

class LandDetails extends StatelessWidget {
  const LandDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.landDetails),
        DetailDropdown(
          label: AppStrings.landClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.classificationOptions,
        ),
        DetailTextField(
          label: AppStrings.plotNumberOptional,
          detailKey: DetailKeys.plotNumber,
        ),
        DetailTextField(
          label: AppStrings.planNumberOptional,
          detailKey: DetailKeys.planNumber,
        ),
        SizedBox(height: 16.height),
        SectionTitle(title: AppStrings.landDimensions),
        Row(
          children: [
            Expanded(
              child: DetailTextField(
                label: AppStrings.dimensionNorth,
                detailKey: DetailKeys.dimensionNorth,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: DetailTextField(
                label: AppStrings.dimensionSouth,
                detailKey: DetailKeys.dimensionSouth,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DetailTextField(
                label: AppStrings.dimensionEast,
                detailKey: DetailKeys.dimensionEast,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: DetailTextField(
                label: AppStrings.dimensionWest,
                detailKey: DetailKeys.dimensionWest,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
          ],
        ),
        DetailTextField(
          label: AppStrings.allowedConstructionRatio,
          detailKey: DetailKeys.buildingRatio,
          isNumeric: true,
          unit: '%',
        ),
        DetailNumberDropdown(
          label: AppStrings.allowedNumberOfFloors,
          detailKey: DetailKeys.allowedFloors,
          options: AddPropertyBloc.numberOptions(50, min: 1),
        ),
        DetailMultiChips(
          label: AppStrings.availableServices,
          detailKey: DetailKeys.services,
          options: AddPropertyBloc.landServiceOptions,
        ),
      ],
    );
  }
}
