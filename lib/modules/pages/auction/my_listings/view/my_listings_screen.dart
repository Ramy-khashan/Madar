import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/my_listings_bloc.dart';
import 'widgets/my_listing_card_widget.dart';
import 'widgets/my_listings_filter_widget.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MyListingsBloc, MyListingsState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.myExhibits),
            body: SafeArea(
              child: Column(
                children: [
                  MyListFilterTabBar(activeFilter: state.activeFilter),

                  Expanded(
                    child: LoadingProcess(
                      status: state.loadStatus,
                      errorMsg: state.errorMsg,
                      onTapRefresh: () => context.read<MyListingsBloc>().add(
                        const MyListingsLoad(),
                      ),
                      emptyMsg: AppStrings.noMyListings,
                      isEmptyList:
                          state.loadStatus == RequestStatus.success &&
                          state.filteredItems.isEmpty,
                      childIsLoader: true,
                      child: GridView.builder(
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
                            mobilePortrait: 250.height,
                            mobileLandscape: 270.height,
            
                            tabletPortrait: 210.height,
                            tabletLandscape: 270.height,
                       
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 12.width,
                          right: 12.width,
                          bottom: 40.height,
                          top: 8.height,
                        ),
                        itemCount: state.loadStatus == RequestStatus.loading
                            ? 12
                            : state.filteredItems.length,

                        itemBuilder: (_, i) => MyListingCardWidget(
                          item: state.loadStatus == RequestStatus.loading
                              ? null
                              : state.filteredItems[i],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
 
    );
  }
}
