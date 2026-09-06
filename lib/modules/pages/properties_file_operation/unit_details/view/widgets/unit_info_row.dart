import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.embedded = false,
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.inputFormatters,
  });

  final String label;
  final String value;
  final String leadingImage;
  final bool showLeadingImage;
  final AppThemeColors colors;
  final TextEditingController? controller;
  final bool isEditable;
  final TextInputType keyboardType;
  final bool embedded;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? suffix;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        if (showLeadingImage && leadingImage.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(10.width),
            decoration: BoxDecoration(
              color: embedded
                  ? colors.borderColor.withValues(alpha: 0.55)
                  : colors.primaryBrand.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.radius),
            ),
            child: ImageItem(
              leadingImage,
              color: embedded ? colors.textSecondary : colors.primaryBrand,
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
                      readOnly: readOnly,
                      onTap: onTap,
                      inputFormatters: inputFormatters,
                      enabled: isEditable || onTap != null,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontWeight: FontWeight.w700,
                        color: colors.textFieldTitle,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        suffixText: suffix,
                        suffixStyle: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w600,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                      ),
                    )
                  : Text(
                      suffix == null || suffix!.isEmpty
                          ? value
                          : '$value $suffix',
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
    );

    if (embedded) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.height),
        child: row,
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: row,
    );
  }
}
