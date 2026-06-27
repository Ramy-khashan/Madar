import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class UnitInfoRow extends StatelessWidget {
  const UnitInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.leadingImage,
    this.showLeadingImage = true,
    required this.colors,
    this.controller,
    this.isEditable = true,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String value;
  final String leadingImage;
  final bool showLeadingImage;
  final AppThemeColors colors;
  final TextEditingController? controller;
  final bool isEditable;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Row(
        children: [
          if (leadingImage.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(10.width),
              decoration: BoxDecoration(
                color: colors.primaryBrand.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.radius),
              ),
              child: ImageItem(
                leadingImage,
                color: colors.primaryBrand,
                width: 12.width,
                height: 12.width,
              ),
            ),

            SizedBox(width: 8.width),
          ],

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
                SizedBox(height: 2.height),
                controller != null
                    ? TextField(
                        controller: controller,
                        textAlign: TextAlign.start,
                        keyboardType: keyboardType,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                          isDense: true,

                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        value,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(width: 8.width),

          if (isEditable)
            ImageItem(AppImages.editPencilIcon, color: colors.textFieldTitle),
        ],
      ),
    );
  }
}
