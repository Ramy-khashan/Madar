import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../controller/real_estate_news_bloc.dart';
import 'news_card_widget.dart';

class RealEstateNewsContentWidget extends StatelessWidget {
  const RealEstateNewsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealEstateNewsBloc, RealEstateNewsState>(
      builder: (context, state) { 
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 8.height,
            horizontal: 12.width,
          ),
          itemCount:state.newsStatus==RequestStatus.success ? state.items.length : 10,
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
              mobilePortrait: 400.height,
              mobileLandscape: 420.height,
              tabletPortrait: 320.height,
              tabletLandscape: 400.height,
            ),
          ),
          itemBuilder: (context, i) =>
              NewsCardWidget(item: state.newsStatus==RequestStatus.success?state.items[i]:null),
        );
      },
    );
  }
}
