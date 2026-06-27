import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.height),
          decoration: BoxDecoration(
            color: AppColors.errorColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(32.radius),
            border: Border.all(
              color: AppColors.errorColor.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.logout,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.errorColor,
                ),
              ),
              SizedBox(width: 8.width),
              const Icon(Icons.logout, color: AppColors.errorColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
