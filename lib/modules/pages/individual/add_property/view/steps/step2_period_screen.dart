import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/field_error_text.dart';

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
                _PeriodOption(
                  period: 'monthly',
                  label: AppStrings.monthly,
                  subtitle: AppStrings.monthlyRentRenewable,
                  icon: Icons.calendar_view_month_rounded,
                ),
                12.height.toSizedBox,
                _PeriodOption(
                  period: 'semi_annual',
                  label: AppStrings.halfYearlyLabel,
                  subtitle: AppStrings.rentEvery6Months,
                  icon: Icons.calendar_view_week_rounded,
                ),
                12.height.toSizedBox,
                _PeriodOption(
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
        _Step2Buttons(tc: tc),
      ],
    );
  }
}

class _PeriodOption extends StatelessWidget {
  const _PeriodOption({
    required this.period,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
  final String period;
  final String label;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.rentalPeriod != curr.model.rentalPeriod,
      builder: (context, state) {
        final isSelected = state.model.rentalPeriod == period;
        return GestureDetector(
          onTap: () =>
              AddPropertyBloc.get(context).add(SelectRentalPeriodEvent(period)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Container(
                  width: 25.width,
                  height: 25.width,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: tc.primaryBrand),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: isSelected
                        ? tc.primaryBrand
                        : tc.onPrimary,
                  ),
                ),
                12.width.toSizedBox,
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.w700,
                      color: isSelected ? tc.primaryBrand : tc.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Step2Buttons extends StatelessWidget {
  const _Step2Buttons({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: AppStrings.back,
              isOutline: true,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const PreviousStepEvent()),
            ),
          ),
          12.width.toSizedBox,
          Expanded(
            child: AppButton(
              text: AppStrings.next,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const NextStepEvent()),
            ),
          ),
        ],
      ),
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());
}
