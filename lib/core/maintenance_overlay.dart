import 'package:flutter/material.dart';
import '../config/theme/app_theme_colors.dart';
import 'components/app_button.dart';
import 'utils/constants/app_constant.dart';
import 'utils/constants/app_strings.dart';
import 'utils/functions/responsive.dart';
import 'app_kill_switch.dart';

class MaintenanceOverlay extends StatelessWidget {
  const MaintenanceOverlay({super.key, required this.kill});

  final AppKillSwitch kill;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final title = kill.title.isEmpty ? AppStrings.appPausedTitle : kill.title;
    final description = kill.description.isEmpty
        ? AppStrings.appPausedDescription
        : kill.description;

    return Positioned.fill(
      child: PopScope(
        canPop: false,
        child: Material(
          color: colors.backgroundPrimary,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72.width,
                    height: 72.width,
                    decoration: BoxDecoration(
                      color: colors.primaryBrand.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.pause_circle_outline_rounded,
                      size: 36.width,
                      color: colors.primaryBrand,
                    ),
                  ),
                  SizedBox(height: 24.height),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(20),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.textFieldTitle,
                    ),
                  ),
                  SizedBox(height: 12.height),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      height: 1.5,
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 32.height),
                  AppButton(
                    childText: AppStrings.appPausedRefresh,
                    childIcon: Icons.refresh_rounded,
                    isLoading: kill.isRefreshing,
                    onTap: kill.refresh,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
