import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/components/guest_locked_view.dart';
import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../../core/components/section_header_widget.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/individual_home_bloc.dart';

class PortfolioPropertiesHomePart extends StatelessWidget {
  const PortfolioPropertiesHomePart({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<IndividualHomeBloc, IndividualHomeState>(
        builder: (context, state) {
           return Padding(
            padding: EdgeInsets.only(bottom: 20.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeaderWidget(
                  title: AppStrings.myPortfolio,
                  onViewAll: () {
                    if (!GuestMode.requireAuth(
                      context,
                      subtitle: AppStrings.guestFeaturesMessage,
                    )) {
                      return;
                    }
                    RouterHandler.navigate(context, AppRouterKeys.myProperties);
                  },
                ),
                if (GuestMode.isGuest)
                  SizedBox(
                    height: ResponsiveUtils.types(
                      context,
                      mobilePortrait: 100.height,
                      mobileLandscape: 110.height,
                      tabletPortrait: 100.height,
                      tabletLandscape: 120.height,
                    ),
                    child: const GuestLockedView(compact: true),
                  )
                else
                SizedBox(
                  height: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 165.height,
                    mobileLandscape: 190.height,
                    tabletPortrait: 150.height,
                    tabletLandscape: 180.height,
                  ),
                  child: LoadingProcess(
                    // status: state.portfolioStatus,
                    status: state.portfolioStatus,
                    errorMsg: state.portfolioErrorMsg,
                    onTapRefresh: () {
                      IndividualHomeBloc.get(
                        context,
                      ).add(const IndividualHomeLoadPortfolio());
                    },
                    emptyMsg: AppStrings.noPortfolioFound,
                    isEmptyList: state.portfolio.isEmpty,
                    childIsLoader: true,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      itemCount: state.portfolioStatus == RequestStatus.loading
                          ? 10
                          : state.portfolio.length,
                      separatorBuilder: (_, _) => SizedBox(width: 12.width),
                      itemBuilder: (context, index) {
                        final item =
                            state.portfolioStatus == RequestStatus.loading
                            ? null
                            : state.portfolio[index];
                        return PortfolioCardWidget(
                          isWithWidth: true,
                          portfolio: item,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
