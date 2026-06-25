import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/search_item.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/choose_broker_bloc.dart';

import 'broker_card_widget.dart';

class BrokerListContentWidget extends StatelessWidget {
  const BrokerListContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.responsiveHorizontalPadding,
            right: context.responsiveHorizontalPadding,
            top: 10.height,
          ),
          child: Text(
            AppStrings.brokerWillManage,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textSecondary,
            ),
          ),
        ),
        const SearchItem(),

        Expanded(
          child: BlocBuilder<ChooseBrokerBloc, ChooseBrokerState>(
            builder: (context, state) {
              final brokers = state.filteredBrokers;
              return GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 4.height,
                ),
                itemCount: brokers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 1,
                    mobileLandscape: 2,
                    tabletPortrait: 2,
                    tabletLandscape: 3,
                  ).toInt(),
                  mainAxisSpacing: 12.height,
                  crossAxisSpacing: 12.width,
                  mainAxisExtent: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 305.height,
                    mobileLandscape: 335.height,
                    tabletPortrait: 225.height,
                    tabletLandscape: 355.height,
                  ),
                ),
                itemBuilder: (_, i) => BrokerCardWidget(broker: brokers[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}
