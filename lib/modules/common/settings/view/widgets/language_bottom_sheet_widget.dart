import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/settings_bloc.dart';
import 'language_option_tile.dart';

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
            (lang) => LanguageOptionTile(
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
