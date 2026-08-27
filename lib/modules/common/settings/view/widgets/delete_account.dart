import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

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
              CupertinoIcons.trash,
              color: AppColors.errorColor,
            ),
          ),
          SizedBox(width: 12.width),
          Text(AppStrings.deleteAccount),
        ],
      ),
      content: Text(AppStrings.deleteAccountConfirmation),
      actions: [
        TextButton(
          onPressed: () => RouterHandler.pop(context),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            AppStrings.confirm,
            style: const TextStyle(color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}
