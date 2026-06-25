import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/router_handler.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.width),
            decoration: BoxDecoration(
              color: AppColors.errorColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.power,
              color: AppColors.errorColor,
            ),
          ),
          SizedBox(width: 12.width),
          Text(AppStrings.logout),
        ],
      ),
      content: Text(AppStrings.logoutConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            RouterHandler.navigate(
              context,
              AppRouterKeys.chooseAccount,
              routerType: RouterType.pushReplacementNamed,
            );
          },
          child: Text(
            AppStrings.confirm,
            style: const TextStyle(color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}
