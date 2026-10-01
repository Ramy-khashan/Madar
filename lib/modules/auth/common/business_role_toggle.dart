import 'package:flutter/material.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/functions/responsive.dart';
import 'role_chip.dart';

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
            child: RoleChip(
              label: AppStrings.brokerRoleShort,
              selected: selectedRole == AppConstant.business,
              onTap: () => onChanged(AppConstant.business),
            ),
          ),
          SizedBox(width: 8.width),
          Expanded(
            child: RoleChip(
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
