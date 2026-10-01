import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/my_listing_item_model.dart';

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
