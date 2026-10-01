import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/my_listing_item_model.dart';
import 'complete_auction_info_cell_item.dart';

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
