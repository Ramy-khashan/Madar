import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../model/my_listing_item_model.dart';
import 'active_body.dart';
import 'completed_body.dart';
import 'cancelled_body.dart';

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
