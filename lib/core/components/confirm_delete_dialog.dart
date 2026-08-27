import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/router_handler.dart';

Future<void> showConfirmDeleteDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () =>RouterHandler.pop(context),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
          RouterHandler.pop(context);
            onConfirm();
          },
          child: Text(
            AppStrings.deleteBtn,
            style: const TextStyle(color: AppColors.errorColor),
          ),
        ),
      ],
    ),
  );
}
