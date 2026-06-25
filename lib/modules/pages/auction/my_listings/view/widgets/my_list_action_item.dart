import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/my_listing_item_model.dart';
import 'complete_auction_info_cell_item.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({super.key, required this.item, required this.colors});
  final MyListingItemModel? item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    switch (item?.status) {
      case 'active':
        return ActiveBody(item: item, colors: colors);
      case 'completed':
        return CompletedBody(item: item, colors: colors);
      case 'cancelled':
        return CancelledBody(item: item, colors: colors);
      default:
        return CancelledBody(item: item, colors: colors);
    }
  }
}

class ActiveBody extends StatelessWidget {
  const ActiveBody({super.key, required this.item, required this.colors});
  final MyListingItemModel? item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (item?.endTime != null) SizedBox(height: 8.height),
        AppButton(
          text: AppStrings.showAuction,
          onTap: () => RouterHandler.navigate(
            context,
            AppRouterKeys.auctionDetails,
            extra: item?.id,
          ),
        ),
      ],
    );
  }
}

class CompletedBody extends StatelessWidget {
  const CompletedBody({super.key, required this.item, required this.colors});
  final MyListingItemModel? item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.width,
            vertical: 14.height,
          ),
          decoration: BoxDecoration(
            color: colors.textFieldFill,
            borderRadius: BorderRadius.circular(14.radius),
            border: Border.all(color: colors.textFieldBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CompleteAuctionInfoCellItem(
                label: AppStrings.finalPriceLabel,
                value:
                    '${item?.finalPrice?.toStringAsFixed(0) ?? '-'} ${AppStrings.currency}',
                colors: colors,
                icon: AppImages.finalPriceIcon,
              ),
              CompleteAuctionInfoCellItem(
                label: AppStrings.deliveryLabel,
                value: item?.deliveryStatus ?? '-',
                colors: colors,
                icon: AppImages.shippingIcon,
              ),
              CompleteAuctionInfoCellItem(
                label: AppStrings.winnerLabel,
                value: item?.winnerName ?? '-',
                colors: colors,
                icon: AppImages.winnerIcon,
              ),
            ],
          ),
        ),
        if (item?.receiptFileName != null) ...[
          SizedBox(height: 8.height),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  size: 16.width,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? colors.onPrimary
                      : colors.primaryBrand,
                ),
                SizedBox(width: 6.width),
                Text(
                  '${AppStrings.paymentReceiptLabel}: ${item?.receiptFileName}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontFamily: AppConstant.appFont,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? colors.onPrimary
                        : colors.primaryBrand,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

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
