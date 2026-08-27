import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class PropertyTypeCard extends StatelessWidget {
  const PropertyTypeCard({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.tc,
  });
  final String id;
  final String label;
  final String icon;
  final bool isSelected;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AddPropertyBloc.get(context).add(SelectPropertyTypeEvent(id)),
      child: AnimatedContainer(
        padding: const EdgeInsets.all(12),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? tc.primaryBrand : tc.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.width,
              height: 40.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? tc.primaryBrand
                    : tc.textFieldHint.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ImageItem(
                icon,
                width: 24.width,
                color: isSelected ? tc.onPrimary : tc.primaryBrand,
              ),
            ),
            6.height.toSizedBox,
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                color: isSelected ? tc.primaryBrand : tc.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
