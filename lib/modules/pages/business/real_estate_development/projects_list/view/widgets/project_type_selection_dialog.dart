import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ProjectTypeSelectionDialog extends StatefulWidget {
  const ProjectTypeSelectionDialog({super.key});

  @override
  State<ProjectTypeSelectionDialog> createState() =>
      _ProjectTypeSelectionDialogState();
}

class _ProjectTypeSelectionDialogState
    extends State<ProjectTypeSelectionDialog> {
  String _selected = 'residential';

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
            _TypeRadioTile(
              value: 'residential',
              groupValue: _selected,
              title: AppStrings.residentialProject,
              subtitle: AppStrings.residentialProjectSubtitle,
              colors: colors,
              onChanged: (v) => setState(() => _selected = v!),
            ),
            SizedBox(height: 12.height),
            _TypeRadioTile(
              value: 'commercial',
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

class _TypeRadioTile extends StatelessWidget {
  const _TypeRadioTile({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.onChanged,
  });

  final String value;
  final String groupValue;
  final String title;
  final String subtitle;
  final AppThemeColors colors;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: groupValue,
      onChanged: onChanged,
      child: RadioListTile<String>(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        minTileHeight: 0,
        value: value,

        activeColor: colors.primaryBrand,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: context.responsiveFontScale(12),
            color: colors.textSecondary,
            fontFamily: AppConstant.appFont,
          ),
        ),
      ),
    );
  }
}
