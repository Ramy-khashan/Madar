import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class DateTypeToggle extends StatelessWidget {
  const DateTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.dateType != curr.model.dateType,
      builder: (context, state) {
        final isGregorian = state.model.dateType == 'gregorian';
        return Container(
          decoration: BoxDecoration(
            color: tc.borderColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(3),
          child: Row(
            children: [
              _DateTypeOption(
                label: AppStrings.gregorian,
                isActive: isGregorian,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectDateTypeEvent('gregorian')),
                tc: tc,
              ),
              _DateTypeOption(
                label: AppStrings.hijri,
                isActive: !isGregorian,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectDateTypeEvent('hijri')),
                tc: tc,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateTypeOption extends StatelessWidget {
  const _DateTypeOption({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          height: 38,
          decoration: BoxDecoration(
            color: isActive ? tc.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w700,
              color: isActive ? tc.onPrimary : tc.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
