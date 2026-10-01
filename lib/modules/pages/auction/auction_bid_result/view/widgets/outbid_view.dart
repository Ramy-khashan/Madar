import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/auction_bid_result_model.dart';
import 'bid_info_row.dart';

class OutbidView extends StatelessWidget {
  const OutbidView({super.key, required this.result});
  final AuctionBidResultModel result;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      color: const Color(0xFFFFF0F0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
          vertical: 24.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Container(
              width: 80.width,
              height: 80.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cancel_outlined,
                size: 50.width,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.height),
            Text(
              AppStrings.bidOutbidTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(22),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              AppStrings.bidOutbidNote,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontFamily: AppConstant.appFont,
                color: colors.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.height),
            BidInfoRow(
              label: AppStrings.yourBidLabel,
              value:
                  '${result.bidAmount.toStringAsFixed(0)} ${AppStrings.currency}',
            ),
            const Spacer(),
            AppButton(
              onTap: () => RouterHandler.pop(context),
              text: AppStrings.placeBidBtn,
            ),
            SizedBox(height: 10.height),
            AppButton(
              onTap: () => RouterHandler.navigate(
                context,
                AppRouterKeys.navbar,
                routerType: RouterType.goName,
              ),
              text: AppStrings.goHome,
              isOutline: true,
            ),
          ],
        ),
      ),
    );
  }
}
