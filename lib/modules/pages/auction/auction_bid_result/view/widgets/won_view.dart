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

class WonView extends StatelessWidget {
  const WonView({super.key, required this.result});
  final AuctionBidResultModel result;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
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
              color: const Color(0xFF22C55E).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              size: 50.width,
              color: const Color(0xFF22C55E),
            ),
          ),
          SizedBox(height: 20.height),
          Text(
            AppStrings.bidWonTitle,
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
            AppStrings.bidWonNote,
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
          SizedBox(height: 8.height),
          BidInfoRow(
            label: AppStrings.propertyInfoSection,
            value: result.propertyTitle,
          ),
          const Spacer(),
          AppButton(
            onTap: () => RouterHandler.navigate(
              context,
              AppRouterKeys.navbar,
              routerType: RouterType.goName,
            ),
            text: AppStrings.goHome,
          ),
        ],
      ),
    );
  }
}
