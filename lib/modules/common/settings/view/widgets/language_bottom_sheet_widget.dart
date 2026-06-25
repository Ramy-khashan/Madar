import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../controller/settings_bloc.dart';

Future<void> showLanguageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(
      value: SettingsBloc.get(context),
      child: const _LanguageBottomSheet(),
    ),
  );
}

class _LanguageBottomSheet extends StatelessWidget {
  const _LanguageBottomSheet();

  static const List<Map<String, String>> _languages = [
    {'code': 'ar', 'label': 'العربية', 'native': 'Arabic'},
    {'code': 'en', 'label': 'English', 'native': 'الإنجليزية'},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.radius)),
      ),
      padding: EdgeInsets.fromLTRB(
        20.width,
        16.height,
        20.width,
        MediaQuery.paddingOf(context).bottom + 24.height,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // handle bar
          Container(
            width: 40.width,
            height: 4.height,
            decoration: BoxDecoration(
              color: colors.borderColor,
              borderRadius: BorderRadius.circular(4.radius),
            ),
          ),
          SizedBox(height: 20.height),
          Text(
            AppStrings.chooseLanguage,
            style: TextStyle(
              fontSize: context.responsiveFontScale(17),
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 20.height),
          ..._languages.map(
            (lang) => _LanguageOptionTile(
              code: lang['code']!,
              label: lang['label']!,
              native: lang['native']!,
              colors: colors,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
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
            await RouterHandler.navigate(
              context,
              AppRouterKeys.navbar,
              routerType: RouterType.goName,
            );
          }
        } else {
          RouterHandler.pop(context);

          await RouterHandler.navigate(
            context,
            AppRouterKeys.navbar,
            routerType: RouterType.goName,
          );
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
