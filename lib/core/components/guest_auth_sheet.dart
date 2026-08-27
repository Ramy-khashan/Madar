import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_button.dart';

Future<void> showGuestAuthSheet(
  BuildContext context, {
  String? title,
  String? subtitle,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => GuestAuthSheet(title: title, subtitle: subtitle),
  );
}

class GuestAuthSheet extends StatelessWidget {
  const GuestAuthSheet({super.key, this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  void _go(BuildContext context, String route) {
    Navigator.of(context).pop();
    RouterHandler.navigate(context, route);
  }

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
          SizedBox(height: 24.height),
          Container(
            width: 64.width,
            height: 64.width,
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 28.width,
              color: colors.primaryBrand,
            ),
          ),
          SizedBox(height: 16.height),
          Text(
            title ?? AppStrings.guestAuthTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.height),
          Text(
            subtitle ?? AppStrings.guestAuthSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              height: 1.4,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 24.height),
          AppButton(
            text: AppStrings.signIn,
            onTap: () => _go(context, AppRouterKeys.signIn),
          ),
          SizedBox(height: 12.height),
          AppButton(
            text: AppStrings.signUp,
            isOutline: true,
            onTap: () => _go(context, AppRouterKeys.signUp),
          ),
        ],
      ),
    );
  }
}
