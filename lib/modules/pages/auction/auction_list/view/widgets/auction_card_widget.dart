import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/property_items.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/auction_item_model.dart';

class AuctionCardWidget extends StatelessWidget {
  const AuctionCardWidget({super.key, this.item});
  final AuctionItemModel? item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(32.radius),
        border: Border.all(color: colors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                ImageItem(
                  item?.imageUrl ?? '',
                   width: double.infinity,
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(32.radius),
                ),
                PositionedDirectional(
                  top: 10.height,
                  end: 20.width,
                  child: StatusBadge(status: item?.status ?? AuctionStatus.live),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.width,
                        vertical: 4.height,
                      ),

                      decoration: BoxDecoration(
                        color: colors.primaryBrand.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.radius),
                      ),
                      child: Text(
                        item?.tag ?? 'Tag',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appFont,
                          color: colors.primaryBrand,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor:colors.borderColor.withValues(alpha: 0.5),
                         
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border, color: AppColors.secondBrand),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item?.title ?? 'Title',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item?.status == AuctionStatus.live) ...[
                      SizedBox(height: 8.height),
                      _CountdownRow(endTime: item?.endTime ?? DateTime.now()),
                    ],
                  ],
                ),
                SizedBox(height: 4.height),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.width,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.width),
                    Expanded(
                      child: Text(
                        item?.location ?? 'Location',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.height),
                  child: Row(
                    children: [
                      PropertyItem(
                        isPrimary: true,
                        label: '${3}',
                        icon: AppImages.bedroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),
                      PropertyItem(
                        isPrimary: true,

                        label: '${2}',
                        icon: AppImages.bathroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),
                      PropertyItem(
                        isPrimary: true,

                        label: '1200 ${AppStrings.mesurement}',
                        icon: AppImages.totalSpaceIcon,
                        colors: colors,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.startingBidLabel,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appFont,
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          '${item?.currentBid.toStringAsFixed(0) ?? '0'} ${AppStrings.currency}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.bidsCountLabel,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                      ),
                      Text(
                        item?.bidsCount.toString() ?? '0',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                    ],
                  ),
                ),

                AppButton(
                  onTap: () {
             RouterHandler.navigate(context,
                      AppRouterKeys.auctionDetails,
                      extra: item?.id ?? 0,
                    );
                  },
                  text: AppStrings.showAuction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final AuctionStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      AuctionStatus.live => (
        AppStrings.auctionLiveTab,
        const Color(0xFF22C55E),
      ),
      AuctionStatus.upcoming => (
        AppStrings.auctionUpcomingTab,
        const Color(0xFFF59E0B),
      ),
      AuctionStatus.ended => (AppStrings.auctionEndedTab, Colors.grey),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 4.width,
            backgroundColor: Colors.white.withValues(alpha: 0.5),
          ),
          SizedBox(width: 4.width),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(12),
              fontFamily: AppConstant.appFont,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownRow extends StatelessWidget {
  const _CountdownRow({required this.endTime});
  final DateTime endTime;

  String _formatDuration(Duration d) {
    if (d.isNegative) return '00:00:00';
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    // final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h ${AppStrings.hoursLabel} $m ${AppStrings.minutesLabel}';
  }

  @override
  Widget build(BuildContext context) {
    // final colors = AppThemeColors.of(context);
    final remaining = endTime.difference(DateTime.now());
    return Row(
      children: [
        Icon(
          CupertinoIcons.clock,
          size: 16.width,
          color: AppColors.secondBrand,
          weight: .9,
        ),
        SizedBox(width: 4.width),
        Text(
          _formatDuration(remaining),
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontFamily: AppConstant.appFont,
            color: AppColors.secondBrand,
          ),
        ),
      ],
    );
  }
}
