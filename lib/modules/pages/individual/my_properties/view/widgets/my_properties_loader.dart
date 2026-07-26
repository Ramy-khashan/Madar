import 'package:flutter/cupertino.dart';

import '../../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class MyPropertiesLoader extends StatelessWidget {
  const MyPropertiesLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.types(
          context,
          mobilePortrait: 1,
          mobileLandscape: 2,
          tabletPortrait: 2,
          tabletLandscape: 3,
        ).toInt(),
        crossAxisSpacing: 12.width,
        mainAxisSpacing: 12.height,
        mainAxisExtent: ResponsiveUtils.types(
          context,
          mobilePortrait: 170.height,
          mobileLandscape: 200.height,
          tabletPortrait: 200.height,
          tabletLandscape: 240.height,
        ).toDouble(),
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const PortfolioCardWidget(portfolio: null);
      },
    );
  }
}
