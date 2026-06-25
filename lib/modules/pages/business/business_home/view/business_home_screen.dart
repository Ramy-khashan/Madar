import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/chatbot_item.dart';
import '../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/components/section_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../individual/individual_home/view/widgets/home_header_widget.dart';
import '../../business_properties/view/widgets/business_properties_request_card_widget.dart';
import '../controller/business_home_bloc.dart';
import 'widget/performace_summary_item.dart';
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
                    const PerformaceSummaryItem(),

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
                 
                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //       bottom: 20.height,
                    //       top: 15.height,
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         SectionHeaderWidget(
                    //           title: AppStrings.myPortfolio,
                    //           onViewAll: () {
                    //             RouterHandler.navigate(
                    //               context,
                    //               AppRouterKeys.businessPropertiesScreen,
                    //             );
                    //           },
                    //           trailing: Padding(
                    //             padding: EdgeInsets.only(right: 8.width),
                    //             child: InkWell(
                    //               borderRadius: BorderRadius.circular(100),
                    //               onTap: () {
                    //                 RouterHandler.navigate(
                    //                   context,
                    //                   AppRouterKeys.propertyLocationMap,
                    //                 );
                    //               },
                    //               child: Container(
                                    
                    //                 padding: EdgeInsets.all(4.width),
                    //                 decoration: BoxDecoration(
                    //                   color: AppThemeColors.of(
                    //                     context,
                    //                   ).primaryBrand,
                    //                   shape: BoxShape.circle,
                    //                   border: Border.all(
                    //                     width: 2.5.width,
                    //                     color: AppThemeColors.of(
                    //                       context,
                    //                     ).borderColor,
                    //                   ),
                    //                 ),
                    //                 child: Icon(
                    //                   Icons.map_outlined,
                    //                   size: 16.width,
                    //                   color: AppThemeColors.of(context).onPrimary,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: ResponsiveUtils.types(
                    //             context,
                    //             mobilePortrait: 285.height,
                    //             mobileLandscape: 300.height,
                    //             tabletPortrait: 280.height,
                    //             tabletLandscape: 300.height,
                    //           ),
                    //           child: ListView.separated(
                    //             scrollDirection: Axis.horizontal,
                    //             padding: EdgeInsets.symmetric(
                    //               horizontal:
                    //                   context.responsiveHorizontalPadding,
                    //             ),
                    //             itemCount: state.portfolio.length,
                    //             separatorBuilder: (_, _) =>
                    //                 SizedBox(width: 12.width),
                    //             itemBuilder: (context, index) {
                    //               final item = state.portfolio[index];
                    //               return BusinessPortflioPropertyItem(
                    //                 isWithWidth: true,
                    //                 portfolio: item,
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

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
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      context.responsiveHorizontalPadding,
                                ),
                                itemCount: state.requests.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 12.width),
                                itemBuilder: (context, index) {
                                  final item = state.requests[index];
                                  return SizedBox(
                                    width: context.screenWidth * (context.isTablet ? 0.4 : 0.9),
                                    child: BusinessPropertiesRequestCardWidget(
                                      isWithActionButtons: false,
                                      item: item,
                                    ),
                                  );
                                },
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
