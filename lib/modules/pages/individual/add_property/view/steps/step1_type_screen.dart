import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/add_property_validator.dart';
import '../widgets/add_property_step_buttons.dart';
import '../widgets/field_error_text.dart';
import '../widgets/operation_toggle.dart';
import '../widgets/property_type_grid.dart';

class AddPropertyStep1Screen extends StatelessWidget {
  const AddPropertyStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.propertyTypeAndOperation,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
                6.height.toSizedBox,
                Text(
                  AppStrings.startWithBasicsHint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w400,
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                Text(
                  AppStrings.doYouWant,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    color: tc.primaryBrand,
                  ),
                ),
                6.height.toSizedBox,
                const OperationToggle(),
                const PropertyTypeGrid(),
                const FieldErrorText(AddPropertyField.propertyType),
              ],
            ),
          ),
        ),
        const AddPropertyStepButtons(showBack: false),
      ],
    );
  }
}
