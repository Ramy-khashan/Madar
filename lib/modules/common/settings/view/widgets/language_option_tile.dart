import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../controller/settings_bloc.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.code,
    required this.label,
    required this.native,
    required this.colors,
  });

  final String code;
  final String label;
  final String native;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    final isSelected = currentLocale == code;

    return GestureDetector(
      onTap: () async {
        if (!isSelected) {
          await changeLanguage(context, code);
          if (context.mounted) {
            SettingsBloc.get(context).add(SettingsLanguageChanged(code));

            RouterHandler.pop(context);
            if (sl.get<PreferenceUtils>().getString(StorageKeys.accountType) ==
                AppConstant.developer) {
              await RouterHandler.navigate(
                context,
                AppRouterKeys.projectManagerHome,
                routerType: RouterType.goName,
              );
            } else {
              await RouterHandler.navigate(
                context,
                AppRouterKeys.navbar,
                routerType: RouterType.goName,
              );
            }
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 10.height),
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryBrand.withValues(alpha: 0.08)
              : colors.cardBackground,
          borderRadius: BorderRadius.circular(14.radius),
          border: Border.all(
            color: isSelected ? colors.primaryBrand : colors.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? colors.primaryBrand
                        : colors.textPrimary,
                  ),
                ),
                Text(
                  native,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: colors.primaryBrand, size: 22),
          ],
        ),
      ),
    );
  }
}
