import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/auction_item_model.dart';

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
