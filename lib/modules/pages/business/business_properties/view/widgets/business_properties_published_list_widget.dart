import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/business_property_request_model.dart';
import 'business_properties_published_card_widget.dart';

class BusinessPropertiesPublishedListWidget extends StatelessWidget {
  const BusinessPropertiesPublishedListWidget({
    super.key,
    required this.items,
    this.actionRequestId,
    this.isActionLoading = false,
  });

  final List<BusinessRequestPublishedPropertyModel> items;
  final String? actionRequestId;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(AppStrings.businessPropertiesNoPublished));
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.height),
      itemBuilder: (context, index) {
        final item = items[index];
        return BusinessPropertiesPublishedCardWidget(
          item: item,
          isActionLoading: isActionLoading && actionRequestId == item.id,
        );
      },
    );
  }
}
