import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/validate.dart';

class AcceptRequestDialog extends StatefulWidget {
  const AcceptRequestDialog({
    super.key,
    this.initialLicense = '',
    this.requireLicense = true,
    this.message,
  });

  final String initialLicense;
  final bool requireLicense;
  final String? message;

  @override
  State<AcceptRequestDialog> createState() => _AcceptRequestDialogState();
}

class _AcceptRequestDialogState extends State<AcceptRequestDialog> {
  late final TextEditingController _licenseController;

  @override
  void initState() {
    super.initState();
    _licenseController = TextEditingController(text: widget.initialLicense);
  }

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  void _confirm() {
    if (widget.requireLicense) {
      final license = _licenseController.text.trim();
      if (!Validate.isLicenseNumber(license)) {
        AppToast(AppStrings.adLicenseMustBe10Digits, isError: true);
        return;
      }
      RouterHandler.pop(context, license);
      return;
    }
    RouterHandler.pop(context, '');
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
              AppStrings.acceptRequestTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 12.height),
            Text(
              widget.message ?? AppStrings.acceptRequestMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
                height: 1.5,
              ),
            ),
            if (widget.requireLicense) ...[
              SizedBox(height: 16.height),
              AppTextField(
                isWithTitle: true,
                title: AppStrings.adLicenseLabel,
                hint: AppStrings.adLicenseLabel,
                controller: _licenseController,
                textInputType: TextInputType.number,
                maxLength: Validate.licenseNumberLength,
                inputFormatters: Validate.licenseNumberFormatters,
              ),
            ],
            SizedBox(height: 16.height),
            AppButton(
              text: AppStrings.confirm,
              height: 48,
              textSize: 16,
              onTap: _confirm,
            ),
            SizedBox(height: 8.height),
            AppButton(
              text: AppStrings.cancel,
              height: 48,
              textSize: 16,
              isOutline: true,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
