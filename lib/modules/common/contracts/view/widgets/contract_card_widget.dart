import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../model/contract_model.dart';
import 'contact_type_tag.dart';
import 'status_badge_item.dart';

class ContractCardWidget extends StatelessWidget {
  const ContractCardWidget({
    super.key,
    required this.contract,
    required this.onTap,
  });

  final ContractModel contract;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(color: colors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const ImageItem(AppImages.contractImage),

                SizedBox(width: 10.width),
                Expanded(
                  child: Text(
                    contract.title,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.w700,
                      color: colors.textFieldTitle,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.width),

                ContractStatusBadge(status: contract.status),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.height),
              child: Text(
                contract.propertyName,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w500,
                  color: colors.primaryBrand,
                ),
              ),
            ),
            Row(
               children: [
                TypeBadge(type: contract.type, colors: colors),
SizedBox(width: 12.width),
                Text(
                  contract.date,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textSecondary,
                  ),
                ),
                Spacer(),
                if(PreferenceUtils().getString(StorageKeys.accountType)==AppConstant.business)
                  Text(
                    '${formatPrice(contract.amount,)} ${AppStrings.currency}',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.w700,
                      color: colors.primaryBrand,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
