import 'package:flutter/material.dart';
import '../../../config/theme/app_theme_colors.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/functions/responsive.dart';
import 'role_radio_row.dart';

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
              child: RoleRadioRow(
                label: AppStrings.brokerRoleShort,
                selected: selectedRole == AppConstant.business,
                onTap: () => onChanged(AppConstant.business),
              ),
            ),
            Expanded(
              child: RoleRadioRow(
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
