import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/components/chatbot_item.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/components/section_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../../properties/view/properties_listing_screen.dart';
import '../controller/individual_home_bloc.dart';
import 'widgets/home_banner_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/portfolio_properties_home_part.dart';
import 'widgets/properties_indvidual_home_part.dart';
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
                return RefreshIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  notificationPredicate: (_) => true,
                  onRefresh: () async => IndividualHomeBloc.get(
                    context,
                  ).add(const IndividualHomeLoad()),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomeHeaderWidget(
                          userLocation: state.userLocation,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SearchItem(
                          onSubmitted: (value) {
                            PropertiesListingScreen.open(
                              context,
                              search: value,
                            );
                          },
                          onFilterTap: () {
                            showFilterSheet(
                              context,
                              onApply: (result) {
                                PropertiesListingScreen.open(
                                  context,
                                  filter: result,
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SliverToBoxAdapter(child: HomeBannerWidget()),

                      const PropertiesIndvidualHomePart(),
                      const PortfolioPropertiesHomePart(),
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
                                  horizontal:
                                      context.responsiveHorizontalPadding,
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
                                        mobilePortrait: 225.height,
                                        mobileLandscape: 210.height,
                                        tabletPortrait: 145.height,
                                        tabletLandscape: 210.height,
                                      ),
                                    ),
                                itemCount:
                                    IndividualHomeBloc
                                        .mockSmartServices
                                        .length -
                                    (isTablet ? 0 : 1),
                                itemBuilder: (context, index) {
                                  final service = IndividualHomeBloc
                                      .mockSmartServices[index];
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
                  ),
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
