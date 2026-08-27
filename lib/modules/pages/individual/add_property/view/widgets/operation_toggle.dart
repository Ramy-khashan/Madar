import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

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
              _ToggleOption(
                label: AppStrings.sellLabel,
                isActive: isSell,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectOperationTypeEvent('sell')),
                tc: tc,
              ),
              _ToggleOption(
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

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
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
          height: 44,
          decoration: BoxDecoration(
            color: isActive ? tc.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              color: isActive ? tc.onPrimary : tc.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
