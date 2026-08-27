import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.onToggle,
  });

  final IconData icon;
  final String label;
  final bool value;
  final AppThemeColors colors;
  final VoidCallback onToggle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.radius),
        color: colors.hoverColor.withValues(alpha: 0.1),
        border: Border.all(color: colors.borderColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.height, vertical: 14.height),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.width, color: colors.primaryBrand),
          ),
          SizedBox(width: 12.width),

          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w500,
              color: colors.textFieldTitle,
            ),
          ),

          const Spacer(),
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: ResponsiveUtils.types(
                context,
                mobilePortrait: 52.width,
                mobileLandscape: 80.width,
                tabletPortrait: 120.width,
                tabletLandscape: 70.width,
              ),
              height: 30.height,
              padding: EdgeInsets.all(3.width),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor),
                color: value
                    ? AppColors.backgroundLight
                    : colors.borderColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.radius),
              ),
              child: Row(
                children: [
                  if (value)
                    Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.on,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(8),
                            fontWeight: FontWeight.w600,
                            fontFamily: AppConstant.appHeaderFont,
                            color: AppColors.secondBrand,
                          ),
                        ),
                      ),
                    ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    alignment: value
                        ? AlignmentDirectional.centerEnd
                        : AlignmentDirectional.centerStart,
                    child: Container(
                      width: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 20.width,
                        mobileLandscape: 30.width,
                        tabletPortrait: 50.width,
                        tabletLandscape: 30.width,
                      ),
                      height: 30.width,
                      decoration: const BoxDecoration(
                        color: AppColors.secondBrand,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  if (!value)
                    Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.off,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(8),
                            fontWeight: FontWeight.w600,
                            fontFamily: AppConstant.appHeaderFont,
                            color: AppColors.secondBrand,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
