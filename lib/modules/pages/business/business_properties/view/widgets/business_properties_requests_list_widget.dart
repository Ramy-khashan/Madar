import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/business_property_request_model.dart';
import 'business_properties_request_card_widget.dart';

class BusinessPropertiesRequestsListWidget extends StatelessWidget {
  const BusinessPropertiesRequestsListWidget({
    super.key,
    required this.items,
    this.actionRequestId,
    this.isActionLoading = false,
  });

  final List<BusinessPropertyRequestModel> items;
  final String? actionRequestId;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(AppStrings.businessPropertiesNoRequests));
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.types(
          context,
          mobilePortrait: 1,
          mobileLandscape: 2,
          tabletPortrait: 2,
          tabletLandscape: 3,
        ).toInt(),
        crossAxisSpacing: 16.width,
        mainAxisSpacing: 16.height,
        mainAxisExtent: ResponsiveUtils.types(
          context,
          mobilePortrait: 230.height,
          mobileLandscape: 230.height,
          tabletPortrait: 180.height,
          tabletLandscape: 220.height,
        ).toDouble(),
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return BusinessPropertiesRequestCardWidget(
          item: item,
          isActionLoading: isActionLoading && actionRequestId == item.requestId,
        );
      },
    );
  }
}
