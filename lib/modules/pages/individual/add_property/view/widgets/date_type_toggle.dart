import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../controller/add_property_bloc.dart';
import 'date_type_option.dart';

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
              DateTypeOption(
                label: AppStrings.gregorian,
                isActive: isGregorian,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectDateTypeEvent('gregorian')),
                tc: tc,
              ),
              DateTypeOption(
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
