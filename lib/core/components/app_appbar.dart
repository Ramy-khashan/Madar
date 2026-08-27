import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar({
    super.key,
    this.actions,
    this.title,
    this.centerTitle = true,
    this.isWithBack = true,
    this.onTapBack,
  });
  final List<Widget>? actions;
  final String? title;
  final bool centerTitle;
  final bool isWithBack;
  final VoidCallback? onTapBack;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: isWithBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed:
                  onTapBack ??
                  () {
                    RouterHandler.pop(context);
                  },
            )
          : const SizedBox.shrink(),
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: context.responsiveFontScale(20),
          fontWeight: FontWeight.w500,
          fontFamily: AppConstant.appHeaderFont,
          color: AppThemeColors.of(context).textFieldTitle,
        ),
      ),
      actions: [...?actions],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
