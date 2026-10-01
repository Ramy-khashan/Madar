import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'toggle_option.dart';

class OperationToggle extends StatelessWidget {
  const OperationToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.operationType != curr.model.operationType,
      builder: (context, state) {
        final isSell = state.model.operationType == 'sell';
        return Container(
          margin: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: tc.borderColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              ToggleOption(
                label: AppStrings.sellLabel,
                isActive: isSell,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectOperationTypeEvent('sell')),
                tc: tc,
              ),
              ToggleOption(
                label: AppStrings.rentLabel,
                isActive: !isSell,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectOperationTypeEvent('rent')),
                tc: tc,
              ),
            ],
          ),
        );
      },
    );
  }
}
