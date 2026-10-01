import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import 'type_radio_tile.dart';

class ProjectTypeSelectionDialog extends StatefulWidget {
  const ProjectTypeSelectionDialog({super.key});

  @override
  State<ProjectTypeSelectionDialog> createState() =>
      _ProjectTypeSelectionDialogState();
}

class _ProjectTypeSelectionDialogState
    extends State<ProjectTypeSelectionDialog> {
  String _selected = AppConstant.residentialProjectType;

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
              AppStrings.chooseProjectType,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 20.height),
            TypeRadioTile(
              value: AppConstant.residentialProjectType,
              groupValue: _selected,
              title: AppStrings.residentialProject,
              subtitle: AppStrings.residentialProjectSubtitle,
              colors: colors,
              onChanged: (v) => setState(() => _selected = v!),
            ),
            SizedBox(height: 22.height),
            TypeRadioTile(
              value: AppConstant.commercialProjectType,
              groupValue: _selected,
              title: AppStrings.commercialProject,
              subtitle: AppStrings.commercialProjectSubtitle,
              colors: colors,
              onChanged: (v) => setState(() => _selected = v!),
            ),
            SizedBox(height: 20.height),
            AppButton(
              text: AppStrings.chooseBtn,
              height: 48,
              textSize: 16,
              onTap: () => Navigator.of(context).pop(_selected),
            ),
          ],
        ),
      ),
    );
  }
}
