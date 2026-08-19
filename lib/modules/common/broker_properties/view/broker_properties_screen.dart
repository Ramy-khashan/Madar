import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/components/pagination.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
import '../../../../../core/components/user_info_header_widget.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/broker_properties_bloc.dart';
import 'widgets/loading_grid_item.dart';

class BrokerPropertiesScreen extends StatelessWidget {
  const BrokerPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.brokerPropertiesTitle),
      body: SafeArea(
        child: BlocBuilder<BrokerPropertiesBloc, BrokerPropertiesState>(
          builder: (context, state) {
            return Column(
              children: [
                UserInfoHeaderWidget(
                  name: state.brokerName,
                  propertiesCount: state.brokerPropertiesCount,
                  imageUrl: state.brokerImageUrl,
                  isBroker: true,
                ),
                Expanded(
                  child: LoadingProcess(
                    status: state.isLoadMore
                        ? RequestStatus.success
                        : state.loadingStatus,
                    errorMsg: state.errorMsg,
                    emptyMsg: AppStrings.noPropertiesFound,
                    isEmptyList: state.properties.isEmpty,
                    onTapRefresh: () => context
                        .read<BrokerPropertiesBloc>()
                        .add(BrokerPropertiesLoad(brokerId: state.brokerId)),
                    loader: const LoadingGridItem(),
                    child: PaginationView(
                      pageSize: context.read<BrokerPropertiesBloc>().pageSize,
                      items: state.properties,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 400.height,
                        mobileLandscape: 420.height,
                        tabletPortrait: 335.height,
                        tabletLandscape: 405.height,
                      ),
                      countItemInRow: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      requestStatus: state.loadingStatus,
                      hasReachedMax:
                          state.properties.length >= state.totalCount,
                      onLoadMore: (page) =>
                          context.read<BrokerPropertiesBloc>().add(
                            BrokerPropertiesLoad(
                              brokerId: state.brokerId,
                              page: page,
                              isLoadMore: true,
                            ),
                          ),
                      itemBuilder: (context, index) {
                        final property = state.properties[index];
                        return PropertyCardWidget(
                          property: property,
                          footer: PropertyCardChatFooter(
                            onChat: () {
                              RouterHandler.navigate(
                                context,
                                AppRouterKeys.conversationDetail,
                                // extra: ConversationInfo(
                                //   conversationId: property.id,
                                //   participantName: property.title,
                                //   participantAvatarUrl: property.imageUrl,
                                // ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
