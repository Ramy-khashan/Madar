import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/repository/apis/auth_apis.dart';
import '../../../../../core/utils/functions/router_handler.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool _isLoading = false;

  Future<void> _logout() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await AuthApis.logoutAndGoToChooseAccount(context);
    if (mounted) setState(() => _isLoading = false);
  }

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
          onPressed: _isLoading ? null : () => RouterHandler.pop(context),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: _isLoading ? null : _logout,
          child: _isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  AppStrings.confirm,
                  style: const TextStyle(color: AppColors.errorColor),
                ),
        ),
      ],
    );
  }
}
