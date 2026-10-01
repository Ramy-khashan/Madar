import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/my_listing_item_model.dart';

class CancelledBody extends StatelessWidget {
  const CancelledBody({super.key, required this.item, required this.colors});
  final MyListingItemModel? item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, size: 14.width, color: Colors.red),
            SizedBox(width: 4.width),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppStrings.cancellationReasonLabel}: ',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontFamily: AppConstant.appFont,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: item?.cancellationReason ?? '',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontFamily: AppConstant.appFont,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (item?.cancelledAt != null) ...[
          SizedBox(height: 4.height),
          Text(
            '${AppStrings.cancelledAtLabel}: ${DateFormat("MMMM d, yyyy").format(item?.cancelledAt ?? DateTime.now())}',
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appFont,
              color: colors.textSecondary,
            ),
          ),
        ],
        SizedBox(height: 8.height),
        AppButton(
          childIcon: Icons.refresh_outlined,

          childText: AppStrings.rePublishAuction,
          onTap: () {},
          isOutline: false,
        ),
      ],
    );
  }
}
