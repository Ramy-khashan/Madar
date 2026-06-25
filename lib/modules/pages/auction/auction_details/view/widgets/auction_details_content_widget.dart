import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/components/responsive_row_column.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../auction_deposit/view/widgets/auction_deposit_amount_card_widget.dart';
import '../../controller/auction_details_bloc.dart';
import '../../model/auction_details_model.dart';
import 'acution_timer_part.dart';
part 'auction_details_info_row.dart';
part 'property_spec_item.dart';

class AuctionDetailsContentWidget extends StatelessWidget {
  const AuctionDetailsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return BlocBuilder<AuctionDetailsBloc, AuctionDetailsState>(
      builder: (context, state) {
        final auction = state.auction;
        if (auction == null) return const SizedBox();
        final colors = AppThemeColors.of(context);

        return IsScrollableWidget(
          isScroll: !isTablet,
          child: ResponsiveRowColumn(
            isTablet: isTablet,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isTablet ? 1 : 0,
                child: IsScrollableWidget(
                  isScroll: isTablet,

                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 230.height,
                            child: PageView.builder(
                              itemCount: auction.imageUrls.length,
                              itemBuilder: (_, i) => ImageItem(
                                auction.imageUrls[i],
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(12.radius),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12.height,
                            right: 12.width,
                            child: Container(
                              width: 36.width,
                              height: 36.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                size: 20.width,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      AcutionTimerPart(auction: auction),
                      OutlinedSection(
                        title: auction.title,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${AppStrings.startingBidLabel}: ${auction.startingBid.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} ${AppStrings.currency}',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontFamily: AppConstant.appFont,
                                fontWeight: FontWeight.w600,
                                color: colors.primaryBrand,
                              ),
                            ),
                            SizedBox(height: 12.height),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 15.width,
                                  color: colors.textSecondary,
                                ),
                                SizedBox(width: 4.width),
                                Text(
                                  auction.location,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(16),
                                    fontFamily: AppConstant.appFont,
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PropertySpecItem(
                                  icon: Icons.bed_outlined,
                                  value: '${auction.beds}',
                                  colors: colors,
                                ),
                                PropertySpecItem(
                                  icon: Icons.bathtub_outlined,
                                  value: '${auction.baths}',
                                  colors: colors,
                                ),
                                PropertySpecItem(
                                  icon: Icons.crop_square_rounded,
                                  value: auction.area,
                                  colors: colors,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.height),
                      OutlinedSection(
                        title: AppStrings.descriptionSection,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              auction.description,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                fontFamily: AppConstant.appFont,
                                color: colors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.height),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: isTablet ? 1 : 0,
                child: IsScrollableWidget(
                  isScroll: isTablet,

                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedSection(
                          title: AppStrings.auctionInfoSection,
                          imageUrl: AppImages.occupancyIcon,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 12.height),
                              AuctionDetailsInfoRow(
                                label: AppStrings.startingBidLabel,
                                value:
                                    '${formatPrice(auction.startingBid)} ${AppStrings.currency}',
                                colors: colors,
                              ),
                              AuctionDetailsInfoRow(
                                isHighestBid: true,
                                label: AppStrings.highestBidLabel,
                                value:
                                    '${formatPrice(auction.currentBid)} ${AppStrings.currency}',
                                colors: colors,
                                valueColor: colors.primaryBrand,
                              ),
                              AuctionDetailsInfoRow(
                                label: AppStrings.minBidIncrementLabel,
                                value:
                                    '${formatPrice(auction.minBidIncrement)} ${AppStrings.currency}',
                                colors: colors,
                              ),
                              AuctionDetailsInfoRow(
                                label: AppStrings.auctionStartLabel,
                                value: DateFormat(
                                  'yyyy/MM/dd HH:mm a',
                                ).format(auction.startTime),
                                colors: colors,
                              ),
                              AuctionDetailsInfoRow(
                                label: AppStrings.auctionEndLabel,
                                value: DateFormat(
                                  'yyyy/MM/dd HH:mm a',
                                ).format(auction.endTime),
                                colors: colors,
                              ),
                              AuctionDetailsInfoRow(
                                label: AppStrings.auctionStatusLabel,
                                colors: colors,
                                customValue: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.width,
                                    vertical: 4.height,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AuctionDetailsModel.color(
                                      context,
                                      auction.status,
                                    ).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(
                                      20.radius,
                                    ),
                                  ),
                                  child: Text(
                                    AuctionDetailsModel.label(auction.status),
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(12),
                                      fontWeight: FontWeight.w600,
                                      color: AuctionDetailsModel.color(
                                        context,
                                        auction.status,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.height),

                        OutlinedSection(
                          title: AppStrings.sellerInfoSection,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.shield,
                                    color: AppColors.successColor,
                                  ),
                                  SizedBox(width: 8.width),
                                  Text(
                                    auction.sellerName,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(15),
                                      fontFamily: AppConstant.appHeaderFont,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.height),
                              Row(
                                children: [
                                  Text(
                                    '(${auction.sellerReviewCount} ${AppStrings.ratingLabel})',
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      fontFamily: AppConstant.appFont,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(width: 6.width),
                                  Icon(
                                    Icons.star_rounded,
                                    size: 18.width,
                                    color: const Color(0xFFFFC107),
                                  ),
                                  SizedBox(width: 4.width),
                                  Text(
                                    auction.sellerRating.toString(),
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      fontFamily: AppConstant.appHeaderFont,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textFieldTitle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.height),
                              AppButton(
                                onTap: () {
                                  RouterHandler.navigate(
                                    context,
                                    AppRouterKeys.ownerProperties,
                                  );
                                },
                                text: AppStrings.viewSellerProfile,
                                isOutline: true,
                              ),
                            ],
                          ),
                        ),

                        if (!auction.hasDepositPaid) ...[
                          SizedBox(height: 12.height),
                          AuctionDepositAmountCardWidget(
                            depositAmount: auction.depositAmount,
                          ),
                        ],

                        SizedBox(height: 16.height),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
