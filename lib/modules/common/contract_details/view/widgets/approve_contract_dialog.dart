import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/responsive.dart';

class ApproveContractResult {
  const ApproveContractResult({
    required this.durationInYears,
    required this.finalPrice,
  });

  final String durationInYears;
  final num finalPrice;
}

class ApproveContractDialog extends StatefulWidget {
  const ApproveContractDialog({
    super.key,
    this.initialPrice,
    this.showDuration = false,
  });

  final num? initialPrice;
  final bool showDuration;

  @override
  State<ApproveContractDialog> createState() => _ApproveContractDialogState();
}

class _ApproveContractDialogState extends State<ApproveContractDialog> {
  late final TextEditingController _durationController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(text: '1');
    final price = widget.initialPrice;
    _priceController = TextEditingController(
      text: price == null || price == 0 ? '' : formatPrice(price.toDouble()),
    );
  }

  @override
  void dispose() {
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _confirm() {
    final duration = widget.showDuration
        ? _durationController.text.trim()
        : '';
    final price = parsePrice(_priceController.text);
    if (widget.showDuration && duration.isEmpty) {
      AppToast(AppStrings.pleaseEnterContractDuration, isError: true);
      return;
    }
    if (price == null || price <= 0) {
      AppToast(AppStrings.pleaseEnterContractPrice, isError: true);
      return;
    }
    Navigator.of(context).pop(
      ApproveContractResult(durationInYears: duration, finalPrice: price),
    );
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
            SizedBox(height: 16.height),
            if (widget.showDuration) ...[
              AppTextField(
                isWithTitle: true,
                title: AppStrings.contractDurationYears,
                hint: AppStrings.contractDurationYears,
                controller: _durationController,
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 12.height),
            ],
            AppTextField(
              isWithTitle: true,
              title: AppStrings.contractFinalPrice,
              hint: AppStrings.contractFinalPrice,
              controller: _priceController,
              textInputType: TextInputType.number,
              isPrice: true,
            ),
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
