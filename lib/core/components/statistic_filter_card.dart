import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../../core/utils/functions/responsive.dart';
import 'outline_section.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({
    super.key,
    required this.title,
    required this.options,
    required this.selectedId,
    required this.colors,
    required this.onChanged,
  });

  final String title;
  final List<Map<String, String>> options;
  final String selectedId;
  final AppThemeColors colors;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedSection(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...options.map(
            (opt) => ListTile(
              dense: true,
              minTileHeight: 0,
              onTap: () => onChanged(opt['id']!),
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 20.width,
                height: 20.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedId == opt['id']
                        ? colors.primaryBrand
                        : colors.borderColor,
                    width: 2,
                  ),
                ),
                child: selectedId == opt['id']
                    ? Center(
                        child: Container(
                          width: 10.width,
                          height: 10.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primaryBrand,
                          ),
                        ),
                      )
                    : null,
              ),

              title: Text(
                opt['label']!,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
