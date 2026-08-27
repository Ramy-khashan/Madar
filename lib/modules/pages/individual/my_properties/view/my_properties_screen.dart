import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/guest_locked_view.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/components/pagination.dart';
import '../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/my_properties_bloc.dart';
import 'widgets/my_properties_loader.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.myProperties),
      body: GuestMode.isGuest
          ? const GuestLockedView()
          : SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MyPropertiesBloc, MyPropertiesState>(
                builder: (context, state) {
                  return LoadingProcess(
                    status: state.isLoadMore
                        ? RequestStatus.success
                        : state.propertiesStatus,
                    errorMsg: state.errorMsg,
                    onTapRefresh: () {
                      context.read<MyPropertiesBloc>().add(
                        const MyPropertiesLoad(isLoadMore: false, page: 1),
                      );
                    },
                    emptyMsg: AppStrings.noPropertiesFound,
                    isEmptyList:
                        state.propertiesStatus == RequestStatus.success &&
                        state.properties.isEmpty,
                    loader: const MyPropertiesLoader(),
                    child: PaginationView(
                        countItemInRow: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),

                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                         mobilePortrait: 165.height,
                                mobileLandscape: 190.height,
                                tabletPortrait: 150.height,
                                tabletLandscape: 190.height,
                      ),
                      isListView: context.isMobilePortrait,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.width,
                            vertical: 4.height,
                          ),
                          child: PortfolioCardWidget(
                            portfolio: state.properties[index],
                          ),
                        );
                      },
                      pageSize: MyPropertiesBloc.get(context).pageSize,
                      items: MyPropertiesBloc.get(context).state.properties,
                      requestStatus: MyPropertiesBloc.get(
                        context,
                      ).state.propertiesStatus,
                      hasReachedMax:
                          state.properties.length >= state.totalCount,
                      onLoadMore: (int page) {
                        MyPropertiesBloc.get(
                          context,
                        ).add(MyPropertiesLoad(isLoadMore: true, page: page));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
