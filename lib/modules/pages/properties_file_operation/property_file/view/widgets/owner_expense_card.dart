import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../model/property_file_model.dart';

class OwnerExpenseCard extends StatelessWidget {
  const OwnerExpenseCard({
    super.key,
    required this.expense,
    required this.colors,
    required this.canEdit,
    required this.onRemove,
  });

  final UnitExpenseModel expense;
  final AppThemeColors colors;
  final bool canEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Row(
        children: [
          if ((expense.fileUrl ?? '').isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.radius),
              child: ImageItem(
                expense.fileUrl!,
                width: 48.width,
                height: 48.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.width),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.description.transIfExists,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w700,
                    color: colors.textFieldTitle,
                    fontFamily: AppConstant.appHeaderFont,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  '${formatPrice(expense.amount)} ${AppStrings.currency}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.primaryBrand,
                    fontFamily: AppConstant.appFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (canEdit && !expense.isRemote)
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.errorColor,
                size: 18.width,
              ),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
