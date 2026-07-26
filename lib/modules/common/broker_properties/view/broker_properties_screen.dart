import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/components/user_info_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../../core/model/property_filter_model.dart';
import '../../chats/conversation_detail/model/conversation_info.dart';
import '../../filter/view/filter_sheet_view.dart';
import '../controller/broker_properties_bloc.dart';

class BrokerPropertiesScreen extends StatelessWidget {
  const BrokerPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.brokerPropertiesTitle),
      body: SafeArea(
        child: BlocBuilder<BrokerPropertiesBloc, BrokerPropertiesState>(
          builder: (context, state) {
            if (state is! BrokerPropertiesLoaded) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SearchItem(
                  onFilterTap: () async {
                    await showFilterSheet(
                      context,
                      initialFilter: state.filter,
                      onApply: (PropertyFilterModel filter) {},
                    );
                  },
                ),
                UserInfoHeaderWidget(
                  name: state.broker.name,
                  rating: state.broker.rating,
                  reviewsCount: state.broker.reviewsCount,
                  propertiesCount: state.broker.propertiesCount,
                  imageUrl: state.broker.imageUrl,
                  isBroker: true,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 8.height,
                    ),
                    itemCount: state.properties.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      crossAxisSpacing: 8.width,
                      mainAxisSpacing: 8.height,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 435.height,
                        mobileLandscape: 450.height,
                        tabletPortrait: 375.height,
                        tabletLandscape: 435.height,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final property = state.properties[index];
                      return PropertyCardWidget(
                        property: null,
                        footer: PropertyCardChatFooter(
                          onChat: () {
                            RouterHandler.navigate(
                              context,
                              AppRouterKeys.conversationDetail,
                              extra: ConversationInfo(
                                conversationId: property.id,
                                participantName: property.title,
                                participantAvatarUrl: property.imageUrl,
                              ),
                            );
                          },
                        ),
                      );
                    },
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
