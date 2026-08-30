import 'package:flutter/material.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/functions/responsive.dart';

class BusinessRoleToggle extends StatelessWidget {
  const BusinessRoleToggle({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  final String selectedRole;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.width),
      decoration: BoxDecoration(
        color: colors.hoverColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(32.radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: _RoleChip(
              label: AppStrings.brokerRoleShort,
              selected: selectedRole == AppConstant.business,
              onTap: () => onChanged(AppConstant.business),
            ),
          ),
          SizedBox(width: 8.width),
          Expanded(
            child: _RoleChip(
              label: AppStrings.ownerRoleShort,
              selected: selectedRole == AppConstant.owner,
              onTap: () => onChanged(AppConstant.owner),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessRoleRadios extends StatelessWidget {
  const BusinessRoleRadios({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  final String selectedRole;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.chooseRole,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w500,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appFont,
          ),
        ),
        SizedBox(height: 8.height),
        Row(
          children: [
            Expanded(
              child: _RoleRadioRow(
                label: AppStrings.brokerRoleShort,
                selected: selectedRole == AppConstant.business,
                onTap: () => onChanged(AppConstant.business),
              ),
            ),
            Expanded(
              child: _RoleRadioRow(
                label: AppStrings.ownerRoleShort,
                selected: selectedRole == AppConstant.owner,
                onTap: () => onChanged(AppConstant.owner),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.height),
        decoration: BoxDecoration(
          color: selected ? colors.primaryBrand : AppColors.transparent,
          borderRadius: BorderRadius.circular(32.radius),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w600,
              color: selected ? colors.onPrimary : colors.textSecondary,
              fontFamily: AppConstant.appHeaderFont,
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleRadioRow extends StatelessWidget {
  const _RoleRadioRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.height),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? colors.primaryBrand : colors.textSecondary,
              size: 22.width,
            ),
            SizedBox(width: 8.width),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textPrimary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
