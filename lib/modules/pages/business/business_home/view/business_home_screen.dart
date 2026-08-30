import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/components/loading_process.dart';
import 'package:madar_app/core/utils/constants/app_enums.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/chatbot_item.dart';
import '../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/components/section_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../../../individual/individual_home/view/widgets/home_header_widget.dart';
import '../../../individual/properties/view/properties_listing_screen.dart';
import '../../business_properties/view/widgets/business_properties_request_card_widget.dart';
import '../controller/business_home_bloc.dart';
import 'widget/performance_summary_item.dart';
import 'widget/smart_services_part.dart';

class BusinessHomeScreen extends StatelessWidget {
  const BusinessHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<BusinessHomeBloc, BusinessHomeState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: HomeHeaderWidget(userLocation: state.location),
                    ),
                    // SliverToBoxAdapter(
                    //   child: SearchItem(
                    //     onSubmitted: (value) {
                    //       PropertiesListingScreen.open(context, search: value);
                    //     },
                    //     onFilterTap: () {
                    //       showFilterSheet(
                    //         context,
                    //         onApply: (result) {
                    //           PropertiesListingScreen.open(
                    //             context,
                    //             filter: result,
                    //           );
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                    if (state.performanceSummary.isNotEmpty)
                      PerformanceSummaryItem(
                        performanceSummary: state.performanceSummary,
                      ),

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
                              trailing: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 12.width,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.propertyLocationMap,
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 16.width,
                                    backgroundColor: AppThemeColors.of(
                                      context,
                                    ).primaryBrand,
                                    child: Icon(
                                      Icons.map_outlined,
                                      size: 20.width,
                                      color: AppThemeColors.of(
                                        context,
                                      ).onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 365.height,
                                mobileLandscape: 370.height,
                                tabletPortrait: 330.height,
                                tabletLandscape: 370.height,
                              ),
                              child: LoadingProcess(
                                status: state.businessPropertiesLoadStatus,
                                errorMsg: state.propertiesErrorMessage,
                                onTapRefresh: () {
                                  context.read<BusinessHomeBloc>().add(
                                    const BusinessPropertiesLoad(),
                                  );
                                },
                                emptyMsg: AppStrings.noPropertiesFound,
                                isEmptyList: state.properties.isEmpty,
                                childIsLoader: true,
                                child: ListView.separated(
                                  itemCount:
                                      state.businessPropertiesLoadStatus ==
                                          RequestStatus.loading
                                      ? 10
                                      : state.properties.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        context.responsiveHorizontalPadding,
                                    vertical: 10.height,
                                  ),

                                  separatorBuilder: (_, _) =>
                                      SizedBox(width: 16.width),
                                  itemBuilder: (context, index) {
                                    return PropertyCardWidget(
                                      isWithWidth: true,
                                      property:
                                          state.businessPropertiesLoadStatus ==
                                              RequestStatus.loading
                                          ? null
                                          : state.properties[index],
                                    );
                                  },
                                ),
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
                                tabletLandscape: 190.height,
                              ),
                              child: LoadingProcess(
                                status: state.portfolioLoadStatus,
                                errorMsg: state.portfolioErrorMessage,
                                onTapRefresh: () {
                                  context.read<BusinessHomeBloc>().add(
                                    const PortfolioLoad(),
                                  );
                                },
                                emptyMsg: AppStrings.noPortfolioFound,
                                childIsLoader: true,

                                isEmptyList: state.portfolio.isEmpty,
                                child: ListView.separated(
                                  itemCount:
                                      state.portfolioLoadStatus ==
                                          RequestStatus.loading
                                      ? 10
                                      : state.portfolio.length,

                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        context.responsiveHorizontalPadding,
                                  ),
                                  separatorBuilder: (_, _) =>
                                      SizedBox(width: 12.width),
                                  itemBuilder: (context, index) {
                                    return PortfolioCardWidget(
                                      isWithWidth: true,
                                      portfolio:
                                          state.portfolioLoadStatus ==
                                              RequestStatus.loading
                                          ? null
                                          : state.portfolio[index],
                                    );
                                  },
                                ),
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
                              title: AppStrings.viewRequests,
                              onViewAll: () {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys.businessPropertiesScreen,
                                );
                              },
                            ),
                            SizedBox(
                              height: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 120.height,
                                mobileLandscape: 150.height,
                                tabletPortrait: 150.height,
                                tabletLandscape: 150.height,
                              ),
                              child: LoadingProcess(
                                status: state.requestsLoadStatus,
                                errorMsg: state.requestsErrorMessage,
                                onTapRefresh: () {
                                  context.read<BusinessHomeBloc>().add(
                                    const RequestsLoad(),
                                  );
                                },
                                emptyMsg: AppStrings.noRequestsFound,
                                isEmptyList: state.requests.isEmpty,
                                childIsLoader: true,

                                child: ListView.separated(
                                  itemCount:
                                      state.requestsLoadStatus ==
                                          RequestStatus.loading
                                      ? 10
                                      : state.requests.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        context.responsiveHorizontalPadding,
                                  ),
                                  separatorBuilder: (_, _) =>
                                      SizedBox(width: 12.width),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width:
                                          context.screenWidth *
                                          (context.isTablet ? 0.4 : 0.9),
                                      child:
                                          BusinessPropertiesRequestCardWidget(
                                            isWithActionButtons: false,
                                            item:
                                                state.requestsLoadStatus ==
                                                    RequestStatus.loading
                                                ? null
                                                : state.requests[index],
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmartServicesPart(),
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
