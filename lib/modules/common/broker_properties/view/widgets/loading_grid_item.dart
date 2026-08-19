import 'package:flutter/material.dart';

import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/utils/functions/responsive.dart';

class LoadingGridItem extends StatelessWidget {
  const LoadingGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.types(
          context,
          mobilePortrait: 1,
          mobileLandscape: 2,
          tabletPortrait: 2,
          tabletLandscape: 3,
        ).toInt(),
        mainAxisExtent: ResponsiveUtils.types(
          context,
          mobilePortrait: 435.height,
          mobileLandscape: 450.height,
          tabletPortrait: 375.height,
          tabletLandscape: 435.height,
        ),
      ),
      itemBuilder: (context, index) => const PropertyCardWidget(property: null),
    );
  }
}