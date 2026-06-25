import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ProjectManagerLoginDialog extends StatefulWidget {
  const ProjectManagerLoginDialog({super.key});

  @override
  State<ProjectManagerLoginDialog> createState() =>
      _ProjectManagerLoginDialogState();
}

class _ProjectManagerLoginDialogState
    extends State<ProjectManagerLoginDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Dialog(
      backgroundColor: colors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.radius),
        side: BorderSide(color: colors.borderColor),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.width),
      child: Padding(
        padding: EdgeInsets.all(20.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.managerLoginTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 4.height),
            Text(
              AppStrings.managerLoginSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
            AppTextField(
              title: AppStrings.usernameLabel,
              hint: AppStrings.enterIdentityHint,
              controller: _usernameController,
              textInputType: TextInputType.number,
            ),
            AppTextField(
              title: AppStrings.password,
              hint: AppStrings.enterPassword,
              controller: _passwordController,
              obscureText: _obscurePassword,
              suffixIconWidget: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.width,
                  color: colors.textSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            SizedBox(height: 20.height),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: AppStrings.cancel,
                    isOutline: true,
                    height: 48,
                    textSize: 15,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: AppButton(
                    text: 'تسجيل الدخول',
                    height: 48,
                    textSize: 15,
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
