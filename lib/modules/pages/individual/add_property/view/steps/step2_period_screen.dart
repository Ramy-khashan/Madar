import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

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
                horizontal: 16.width, vertical: 8.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مدة الإيجار',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(18),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
                8.height.toSizedBox,
                Text(
                  'اختر مدة الإيجار المناسبة لعقارك',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: tc.textSecondary,
                  ),
                ),
                24.height.toSizedBox,
                const _PeriodOption(
                  period: 'monthly',
                  label: 'شهري',
                  subtitle: 'إيجار شهري متجدد',
                  icon: Icons.calendar_view_month_rounded,
                ),
                12.height.toSizedBox,
                const _PeriodOption(
                  period: 'semi_annual',
                  label: 'نصف سنوي',
                  subtitle: 'إيجار كل 6 أشهر',
                  icon: Icons.calendar_view_week_rounded,
                ),
                12.height.toSizedBox,
                const _PeriodOption(
                  period: 'annual',
                  label: 'سنة',
                  subtitle: 'إيجار سنوي',
                  icon: Icons.calendar_today_rounded,
                ),
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
          onTap: () => AddPropertyBloc.get(context)
              .add(SelectRentalPeriodEvent(period)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
                horizontal: 16.width, vertical: 8.height),
            decoration: BoxDecoration(
             
              borderRadius: BorderRadius.circular(14),
              
            ),
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
      padding:
          EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: 'رجوع',
              isOutline: true,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const PreviousStepEvent()),
            ),
          ),
          12.width.toSizedBox,
          Expanded(
            child: AppButton(
              text: 'التالي',
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
