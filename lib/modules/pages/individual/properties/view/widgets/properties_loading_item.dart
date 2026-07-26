import 'package:flutter/material.dart';

import '../../../../../../core/components/property_card_footer_widget.dart';
import '../../../../../../core/components/property_card_widget.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertiesLoadingItem extends StatelessWidget {
  const PropertiesLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 8.height,
      ),
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.types(
          context,
          mobilePortrait: 1,
          mobileLandscape: 2,
          tabletPortrait: 2,
          tabletLandscape: 3,
        ).toInt(),
        crossAxisSpacing: 8.width,
        mainAxisSpacing: 8.height,
        mainAxisExtent: ResponsiveUtils.types(
          context,
          mobilePortrait: 395.height,
          mobileLandscape: 420.height,
          tabletPortrait: 325.height,
          tabletLandscape: 395.height,
        ),
      ),
      itemBuilder: (context, index) {
        return PropertyCardWidget(
          property: null,
          footer: PropertyCardDualFooter(onSendRequest: () {}, onChat: () {}),
        );
      },
    );
  }
}
