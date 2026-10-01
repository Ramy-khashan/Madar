import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_number_dropdown.dart';
import 'detail_multi_chips.dart';
import 'detail_bool_radio.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class OfficeDetails extends StatelessWidget {
  const OfficeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.officeDetails),
        DetailNumberDropdown(
          label: AppStrings.floorLabel,
          detailKey: DetailKeys.floor,
          options: AddPropertyBloc.floorNumberOptions,
        ),
        SizedBox(height: 16.height),
        LabeledCounterPair(
          firstLabel: AppStrings.numberOfRooms,
          firstKey: DetailKeys.roomsCount,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.officeFacilityOptions,
        ),
        SizedBox(height: 12.height),
        DetailBoolRadio(
          label: AppStrings.furnishedOffice,
          detailKey: DetailKeys.furnishedOffice,
        ),
        const FurnishingAndCondition(),
      ],
    );
  }
}
