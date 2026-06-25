import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/my_bids_bloc.dart';
import 'widgets/my_bid_card_widget.dart';
import 'widgets/filter_tabbar_item.dart';

class MyBidsScreen extends StatelessWidget {
  const MyBidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MyBidsBloc, MyBidsState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.myBids),
            body: SafeArea(
              child: Column(
                children: [
                  FilterTabBar(activeFilter: state.activeFilter),

                  Expanded(
                    child: LoadingProcess(
                      status: state.loadStatus,
                      errorMsg: state.errorMsg,
                      onTapRefresh: () =>
                          context.read<MyBidsBloc>().add(const MyBidsLoad()),
                      emptyMsg: AppStrings.noMyBids,
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
                            mobilePortrait: 245.height,
                            mobileLandscape: 255.height,
                            tabletPortrait: 170.height,
                            tabletLandscape: 250.height,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 12.width, right: 12.width,bottom: 40.height, top: 8.height),
                        itemCount:state.loadStatus==RequestStatus.loading ?12: state.filteredItems.length ,

                        itemBuilder: (_, i) =>
                            MyBidCardWidget(   item:state.loadStatus==RequestStatus.loading?null: state.filteredItems[i]),
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
