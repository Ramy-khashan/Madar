import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/pagination.dart';
import '../../../../../core/utils/functions/router_handler.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../common/chats/chat_navigator.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../controller/properties_bloc.dart';
import 'widgets/properties_loading_item.dart';

class PropertiesListingScreen extends StatelessWidget {
  const PropertiesListingScreen({super.key});

  static void open(
    BuildContext context, {
    PropertyFilterModel? filter,
    String? search,
  }) {
    RouterHandler.navigate(
      context,
      AppRouterKeys.propertiesListing,
      extra: {
        'filter': ?filter,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.propertiesListingTitle),
      body: SafeArea(
        child: Column(
          children: [
            SearchItem(
              initialQuery: context.read<PropertiesBloc>().state.search,
              onSearchChanged: (value) {
                context.read<PropertiesBloc>().add(
                  PropertiesSearchChanged(value),
                );
              },
              onSubmitted: (value) {
                context.read<PropertiesBloc>().add(
                  PropertiesSearchChanged(value),
                );
              },
              onFilterTap: () {
                showFilterSheet(
                  context,
                  initialFilter: context.read<PropertiesBloc>().state.filter,
                  onApply: (result) {
                    context.read<PropertiesBloc>().add(
                      PropertiesFilterApplied(result),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<PropertiesBloc, PropertiesState>(
                builder: (context, state) {
                  return LoadingProcess(
                    status: state.isLoadMore
                        ? RequestStatus.success
                        : state.propertiesStatus,
                    errorMsg: state.errorMsg,
                    onTapRefresh: () {
                      context.read<PropertiesBloc>().add(
                        const PropertiesLoad(isLoadMore: false, page: 1),
                      );
                    },
                    emptyMsg: AppStrings.noPropertiesFound,
                    isEmptyList:
                        state.propertiesStatus == RequestStatus.success &&
                        state.properties.isEmpty,
                    loader: const PropertiesLoadingItem(),
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
                        mobilePortrait: 365.height,
                        mobileLandscape: 370.height,
                        tabletPortrait: 330.height,
                        tabletLandscape: 370.height,
                      ),
                      isListView: context.isMobilePortrait,
                      itemBuilder: (context, index) {
                        return PropertyCardWidget(
                          property: state.properties[index],
                          isViewAll: true,
                          footer: PropertyCardDualFooter(
                            onSendRequest: () {
                              final id = state.properties[index].propertyId;
                              if (id == null || id.isEmpty) return;
                              RouterHandler.navigate(
                                context,
                                AppRouterKeys.propertyDetails,
                                extra: id,
                              );
                            },
                            onChat: () {
                              ChatNavigator.openPrivateChat(
                                context,
                                receiverId:
                                    state.properties[index].publisherId ?? '',
                                participantName:
                                    state.properties[index].publisherName ?? '',
                                participantAvatarUrl: '',
                              );
                            },
                          ),
                        );
                      },
                      pageSize: PropertiesBloc.get(context).pageSize,
                      items: PropertiesBloc.get(context).state.properties,
                      requestStatus: PropertiesBloc.get(
                        context,
                      ).state.propertiesStatus,
                      hasReachedMax:
                          state.properties.length >= state.totalCount,
                      onLoadMore: (int page) {
                        PropertiesBloc.get(
                          context,
                        ).add(PropertiesLoad(isLoadMore: true, page: page));
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
