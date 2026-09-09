import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class OwnerPublishLicenses {
  const OwnerPublishLicenses({
    required this.adLicenseNumber,
    required this.falLicenseNumber,
  });

  final String adLicenseNumber;
  final String falLicenseNumber;
}

class OwnerPublishLicenseSheet extends StatefulWidget {
  const OwnerPublishLicenseSheet({super.key});

  static Future<OwnerPublishLicenses?> show(BuildContext context) {
    return showModalBottomSheet<OwnerPublishLicenses>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const OwnerPublishLicenseSheet(),
    );
  }

  @override
  State<OwnerPublishLicenseSheet> createState() =>
      _OwnerPublishLicenseSheetState();
}

class _OwnerPublishLicenseSheetState extends State<OwnerPublishLicenseSheet> {
  late final TextEditingController _adLicenseController;
  late final TextEditingController _falLicenseController;

  @override
  void initState() {
    super.initState();
    _adLicenseController = TextEditingController();
    _falLicenseController = TextEditingController();
  }

  @override
  void dispose() {
    _adLicenseController.dispose();
    _falLicenseController.dispose();
    super.dispose();
  }

  void _submit() {
    final adLicense = _adLicenseController.text.trim();
    final falLicense = _falLicenseController.text.trim();
    if (adLicense.isEmpty) {
      AppToast(AppStrings.pleaseEnterAdLicense, isError: true);
      return;
    }
    if (falLicense.isEmpty) {
      AppToast(AppStrings.pleaseEnterFalLicense, isError: true);
      return;
    }
    Navigator.of(context).pop(
      OwnerPublishLicenses(
        adLicenseNumber: adLicense,
        falLicenseNumber: falLicense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: tc.backgroundPrimary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: tc.textPrimary),
              ),
            ),
            AppTextField(
              isWithTitle: true,
              title: AppStrings.adLicenseLabel,
              hint: AppStrings.adLicenseHint,
              controller: _adLicenseController,
            ),
            AppTextField(
              isWithTitle: true,
              title: AppStrings.falLicenseLabel,
              hint: AppStrings.falLicenseHint,
              controller: _falLicenseController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            SizedBox(height: 16.height),
            AppButton(text: AppStrings.saveAndPublish, onTap: _submit),
          ],
        ),
      ),
    );
  }
}
