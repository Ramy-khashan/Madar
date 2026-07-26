import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../notification_screen.dart';

class NotificationLoadingItem extends StatelessWidget {
  const NotificationLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.height),
      itemCount: 10,
      separatorBuilder: (_, _) => Divider(
        color: AppThemeColors.of(context).borderColor,
        indent: 16.width,
        endIndent: 16.width,
        height: 1,
      ),
      itemBuilder: (context, i) {
        return NotificationItem(item: null, onTap: () {});
      },
    );
  }
}
