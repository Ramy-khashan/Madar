import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'loading_item.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Color? textColor, borderColor;
  final VoidCallback? onTap;
  final double radius, textSize;
  final Color? colorBG;
  final bool isLoading;
  final bool isOutline;
  final String? childText;
  final IconData? childIcon;
  final String? childImage;

  final EdgeInsetsGeometry? btnPadding;
  final double? width;
  final double? height;
  final double borderWidth;
  final FontWeight? fontWeight;
  final BorderRadiusGeometry? customBorderRadius;

  const AppButton({
    super.key,
    this.borderColor,
    this.radius = 32,
    this.customBorderRadius,
    this.textSize = 18,
    required this.onTap,
    this.text,
    this.btnPadding,
    this.colorBG,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.isOutline = false,
    this.borderWidth = .6,
    this.fontWeight,
    this.childText,
    this.childIcon,
    this.childImage,
  });

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final TextStyle textStyle = TextStyle(
      color: textColor ?? (isOutline ? tc.primaryBrand : tc.onPrimary),
      fontWeight: FontWeight.w800,
      fontSize: context.responsiveFontScale(textSize),
      fontFamily: AppConstant.appHeaderFont,
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: btnPadding ?? EdgeInsets.zero,
        backgroundColor: isOutline
            ? tc.primaryBrand.withValues(alpha: 0.15)
            : colorBG ?? tc.primaryBrand,
        shadowColor: AppColors.transparent,
        maximumSize: Size(width ?? double.infinity, height ?? 56),
        minimumSize: Size(width ?? double.infinity, height ?? 56),
        shape: RoundedRectangleBorder(
          borderRadius: customBorderRadius ?? BorderRadius.circular(radius),
          side: BorderSide(
            color:
                borderColor ??
                (isOutline ? tc.primaryBrand : Colors.transparent),
            width: borderWidth,
          ),
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: isLoading
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 7.height),
                child: SizedBox(
                  child: LoadingItem(
                    color: isOutline ? tc.textPrimary : tc.onPrimary,
                  ),
                ),
              ),
            )
          : childText != null || childIcon != null || childImage != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: childText != null ? 8.height : 0,
                      end: childText != null ? 6.width : 0,
                      bottom: childText != null ? 5.height : 0,
                    ),
                    child: childIcon != null
                        ? Icon(childIcon, color: textStyle.color)
                        : (childImage != null
                              ? ImageItem(
                                  childImage!,
                                  width: 20.width,
                                  height: 20.width,
                                  color: textStyle.color,
                                )
                              : const SizedBox()),
                                    ),
                  ),
                if (childText != null) Text(childText ?? '', style: textStyle),

              
              ],
            )
          : SizedBox(
              width: width,
              child: Center(child: Text(text ?? '', style: textStyle)),
            ),
    );
  }
}
