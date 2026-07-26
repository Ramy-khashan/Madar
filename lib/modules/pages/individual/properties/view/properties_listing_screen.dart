import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/components/loading_process.dart';
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
import '../../../../common/chats/conversation_detail/model/conversation_info.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../controller/properties_bloc.dart';
import 'widgets/properties_loading_item.dart';

class PropertiesListingScreen extends StatelessWidget {
  const PropertiesListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.propertiesListingTitle),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<PropertiesBloc, PropertiesState>(
              builder: (context, state) {
                final filter = state.propertiesStatus == RequestStatus.success
                    ? state.filter
                    : null;
                return SearchItem(
                  onFilterTap: () async {
                    showFilterSheet(
                      context,
                      initialFilter: filter,
                      onApply: (result) {
                        context.read<PropertiesBloc>().add(
                          PropertiesFilterApplied(result),
                        );
                      },
                    );
                    // final result = await showPropertyFilterSheet(
                    //   context,
                    //   initialFilter: filter,
                    // );
                    // if (result != null && context.mounted) {
                    //   context.read<PropertiesBloc>().add(
                    //     PropertiesFilterApplied(result),
                    //   );
                    // }
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
                      isListView: context.isMobilePortrait,
                      itemBuilder: (context, index) {
                        return PropertyCardWidget(
                          property: state.properties[index],
                          isViewAll: true,
                          footer: PropertyCardDualFooter(
                            onSendRequest: () {},
                            onChat: () {
                              RouterHandler.navigate(
                                context,
                                AppRouterKeys.conversationDetail,
                                extra: ConversationInfo(
                                  conversationId: '',
                                  participantName: '',
                                  participantAvatarUrl: '',
                                ),
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
