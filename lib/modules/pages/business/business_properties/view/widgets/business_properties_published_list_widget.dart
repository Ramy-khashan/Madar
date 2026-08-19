import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
 import '../../model/business_property_request_model.dart';
import 'business_portflio_property_item.dart';
 
class BusinessPropertiesPublishedListWidget extends StatelessWidget {
  const BusinessPropertiesPublishedListWidget({super.key, required this.items});

  final List<BusinessRequestPublishedPropertyModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(AppStrings.businessPropertiesNoPublished));
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 16.width,
        vertical: 8.height,
      ),
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
        mainAxisExtent:  ResponsiveUtils.types(
          context,
          mobilePortrait: 300.height,
          mobileLandscape: 310.height,
          tabletPortrait: 350.height,
          tabletLandscape: 380.height,
        ).toDouble(),
      ),
      itemBuilder: (context, index) =>
          BusinessPortflioPropertyItem(portfolio: items[index]),
    );
  }
}
