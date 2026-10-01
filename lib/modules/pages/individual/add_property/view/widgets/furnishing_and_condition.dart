import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'detail_dropdown.dart';
import 'detail_radio_chips.dart';

class FurnishingAndCondition extends StatelessWidget {
  const FurnishingAndCondition({super.key, this.includeFurnishing = true});

  final bool includeFurnishing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includeFurnishing) ...[
          SizedBox(height: 16.height),
          DetailRadioChips(
            label: AppStrings.furnitureCondition,
            detailKey: DetailKeys.furnishing,
            options: AppConstant.furnishingOptions,
          ),
        ],
        DetailDropdown(
          label: AppStrings.propertyCondition,
          detailKey: DetailKeys.condition,
          options: AddPropertyBloc.conditionOptions,
        ),
      ],
    );
  }
}
