import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/functions/translation.dart';
import '../../config/theme/app_theme_colors.dart';

import '../utils/functions/responsive.dart';

class AppDropDownItem extends StatelessWidget {
  const AppDropDownItem({
    super.key,
    this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = '',
    this.bottomPadding,
  });
  final String? title;
  final String? value;
  final String hintText;
  final double? bottomPadding;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding ?? 8.height,
              top: 15.height,
            ),
            child: Text(
              title ?? '',
              style: TextStyle(
                color: AppThemeColors.of(context).textFieldTitle,
                fontWeight: FontWeight.bold,
                fontSize: context.responsiveFontScale(16),
              ),
            ),
          ),
        Container(
          height: 62.height,
          margin: EdgeInsets.only(
            top: 8,
            bottom: context.isTablet ? 10.height : 6.height,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.radius),
            border: Border.all(
              color: AppThemeColors.of(
                context,
              ).textFieldBorder.withValues(alpha: 0.5),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(18),
                  fontWeight: FontWeight.w400,
                  color: AppThemeColors.of(context).textFieldHint,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.width),
              borderRadius: BorderRadius.circular(25.radius),
              value: value,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppThemeColors.of(context).textSecondary,
                size: 24.radius,
              ),
              items: items
                  .map(
                    (item) =>
                        DropdownMenuItem(value: item, child: Text(item.trans)),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
