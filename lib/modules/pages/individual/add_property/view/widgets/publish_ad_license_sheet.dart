import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PublishAdLicenseSheet extends StatefulWidget {
  const PublishAdLicenseSheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PublishAdLicenseSheet(),
    );
  }

  @override
  State<PublishAdLicenseSheet> createState() => _PublishAdLicenseSheetState();
}

class _PublishAdLicenseSheetState extends State<PublishAdLicenseSheet> {
  late final TextEditingController _licenseController;

  @override
  void initState() {
    super.initState();
    _licenseController = TextEditingController();
  }

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  void _submit() {
    final license = _licenseController.text.trim();
    if (license.isEmpty) {
      AppToast(AppStrings.pleaseEnterAdLicense, isError: true);
      return;
    }
    Navigator.of(context).pop(license);
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
              controller: _licenseController,
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
