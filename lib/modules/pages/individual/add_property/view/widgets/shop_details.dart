import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_text_field.dart';
import 'detail_multi_chips.dart';
import 'furnishing_and_condition.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.shopDetails),
        DetailTextField(
          label: AppStrings.frontagWidth,
          detailKey: DetailKeys.frontWidth,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        DetailDropdown(
          label: AppStrings.location,
          detailKey: DetailKeys.locationType,
          options: AddPropertyBloc.shopLocationOptions,
        ),
        DetailTextField(
          label: AppStrings.mallName,
          detailKey: DetailKeys.mallName,
        ),
        DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.shopFacilityOptions,
        ),
        DetailMultiChips(
          label: AppStrings.shopActivities,
          detailKey: DetailKeys.activities,
          options: AddPropertyBloc.shopActivityOptions,
        ),
        const FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}
