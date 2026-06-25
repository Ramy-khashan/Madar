import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/chatbot_item.dart';
import '../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/components/section_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../controller/individual_home_bloc.dart';
import 'widgets/home_banner_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/smart_service_card_widget.dart';

class IndividualHomeView extends StatelessWidget {
  const IndividualHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<IndividualHomeBloc, IndividualHomeState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: HomeHeaderWidget(userLocation: state.userLocation),
                    ),
                    SliverToBoxAdapter(
                      child: SearchItem(
                        onFilterTap: () {
                          showFilterSheet(
                            context,
                            // initialFilter: filter,
                            onApply: (result) {},
                          );
                        },
                      ),
                    ),

                    const SliverToBoxAdapter(child: HomeBannerWidget()),

                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: context.responsiveHorizontalPadding,
                    //       vertical: 16.height,
                    //     ),
                    //     child: AppButton(
                    //       onTap: () {
                    //         RouterHandler.navigate(
                    //           context,
                    //           AppRouterKeys.addProperty,
                    //         );
                    //       },
                    //       childText: AppStrings.addProperty,
                    //       childIcon: Icons.add_circle_outline,
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 20.height,
                          top: 20.height,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SectionHeaderWidget(
                              title: AppStrings.allProperties,
                              onViewAll: () {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys.propertiesListing,
                                );
                              },
                            ),
                            SizedBox(
                              height: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 365.height,
                                mobileLandscape: 360.height,
                                tabletPortrait: 310.height,
                                tabletLandscape: 350.height,
                              ),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      context.responsiveHorizontalPadding,
                                  vertical: 10.height,
                                ),
                                itemCount: state.properties.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(width: 16.width),
                                itemBuilder: (context, index) {
                                  // final property = state.properties[index];
                                  return PropertyCardWidget(
                                    isWithWidth: true,
                                    property: null,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.height),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SectionHeaderWidget(
                              title: AppStrings.myPortfolio,
                              onViewAll: () {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys.myProperties,
                                );
                              },
                            ),
                            SizedBox(
                              height: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 165.height,
                                mobileLandscape: 190.height,
                                tabletPortrait: 150.height,
                                tabletLandscape: 270.height,
                              ),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      context.responsiveHorizontalPadding,
                                ),
                                itemCount: state.portfolio.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(width: 12.width),
                                itemBuilder: (context, index) {
                                  final item = state.portfolio[index];
                                  return PortfolioCardWidget(
                                    isWithWidth: true,
                                    portfolio: item,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24.height),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SectionHeaderWidget(
                              title: AppStrings.smartServices,
                            ),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.responsiveHorizontalPadding,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: ResponsiveUtils.types(
                                      context,
                                      mobilePortrait: 2,
                                      mobileLandscape: 3,
                                      tabletPortrait: 5,
                                      tabletLandscape: 5,
                                    ).toInt(),
                                    crossAxisSpacing: 12.width,
                                    mainAxisSpacing: 12.height,
                                    mainAxisExtent: ResponsiveUtils.types(
                                      context,
                                      mobilePortrait: 215.height,
                                      mobileLandscape: 210.height,
                                      tabletPortrait: 145.height,
                                      tabletLandscape: 210.height,
                                    ),
                                  ),
                              itemCount:
                                  IndividualHomeBloc.mockSmartServices.length -
                                  (isTablet ? 0 : 1),
                              itemBuilder: (context, index) {
                                final service =
                                    IndividualHomeBloc.mockSmartServices[index];
                                return SmartServiceCardWidget(
                                  service: service,
                                  onTap: () {
                                    if (service.route.isNotEmpty) {
                                      RouterHandler.navigate(
                                        context,
                                        service.route,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            if (!isTablet)
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 12.height,
                                  horizontal:
                                      context.responsiveHorizontalPadding,
                                ),
                                width: double.infinity,
                                height: 200.height,
                                child: SmartServiceCardWidget(
                                  service:
                                      IndividualHomeBloc.mockSmartServices[4],
                                  onTap: () {
                                    if (IndividualHomeBloc
                                        .mockSmartServices[4]
                                        .route
                                        .isNotEmpty) {
                                      RouterHandler.navigate(
                                        context,
                                        IndividualHomeBloc
                                            .mockSmartServices[4]
                                            .route,
                                      );
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const ChatbotItem(),
          ],
        ),
      ),
    );
  }
}
