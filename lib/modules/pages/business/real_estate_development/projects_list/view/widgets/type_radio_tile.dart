import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class TypeRadioTile extends StatelessWidget {
  const TypeRadioTile({
    super.key,
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
      ),
    );
  }
}
