import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/add_property_validator.dart';
import '../widgets/add_property_step_buttons.dart';
import '../widgets/field_error_text.dart';
import '../widgets/period_option.dart';

class AddPropertyStep2Screen extends StatelessWidget {
  const AddPropertyStep2Screen({super.key});

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
                  AppStrings.rentDuration,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(18),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
                8.height.toSizedBox,
                Text(
                  AppStrings.chooseRentDuration,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: tc.textSecondary,
                  ),
                ),
                24.height.toSizedBox,
                PeriodOption(
                  period: 'monthly',
                  label: AppStrings.monthly,
                  subtitle: AppStrings.monthlyRentRenewable,
                  icon: Icons.calendar_view_month_rounded,
                ),
                12.height.toSizedBox,
                PeriodOption(
                  period: 'semi_annual',
                  label: AppStrings.halfYearlyLabel,
                  subtitle: AppStrings.rentEvery6Months,
                  icon: Icons.calendar_view_week_rounded,
                ),
                12.height.toSizedBox,
                PeriodOption(
                  period: 'annual',
                  label: AppStrings.yearLabel,
                  subtitle: AppStrings.yearlyRentLabel,
                  icon: Icons.calendar_today_rounded,
                ),
                const FieldErrorText(AddPropertyField.rentalPeriod),
              ],
            ),
          ),
        ),
        const AddPropertyStepButtons(),
      ],
    );
  }
}
