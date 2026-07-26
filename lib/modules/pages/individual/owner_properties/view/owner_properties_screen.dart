import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
import '../../../../../core/components/property_card_widget.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/components/user_info_header_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../../common/chats/conversation_detail/model/conversation_info.dart';
import '../../../../common/filter/view/filter_sheet_view.dart';
import '../controller/owner_properties_bloc.dart';

class OwnerPropertiesScreen extends StatelessWidget {
  const OwnerPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.ownerPropertiesTitle),
      body: SafeArea(
        child: BlocBuilder<OwnerPropertiesBloc, OwnerPropertiesState>(
          builder: (context, state) {
            if (state is! OwnerPropertiesLoaded) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SearchItem(
                  
                  onFilterTap: () async {
                    showFilterSheet(
                      context,
                      initialFilter: state.filter,
                      onApply: (result) {
                        context.read<OwnerPropertiesBloc>().add(
                              OwnerPropertiesFilterApplied(result),
                            );
                      },
                    );
                  }
                    //   final result = await showPropertyFilterSheet(
                    //     context,
                    //     initialFilter: state.filter,
                    //   );
                    //   if (result != null && context.mounted) {
                    //     context.read<OwnerPropertiesBloc>().add(
                    //       OwnerPropertiesFilterApplied(result),
                    //     );
                    //   }
                    // },
                ),
                UserInfoHeaderWidget(
                  name: state.owner.name,
                  rating: state.owner.rating,
                  reviewsCount: state.owner.reviewsCount,
                  propertiesCount: state.owner.propertiesCount,
                  imageUrl: state.owner.imageUrl,
                  isBroker: false,
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
                       mobilePortrait: 395.height,
                        mobileLandscape: 400.height,
                        tabletPortrait: 325.height,
                        tabletLandscape: 385.height,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return PropertyCardWidget(
                        property: null,
                        // property: state.properties[index],
                        footer: PropertyCardChatFooter(
                          onChat: () {
                            RouterHandler.navigate(
                              context,
                              AppRouterKeys.conversationDetail,
                              extra: ConversationInfo(
                                conversationId: '123',
                                participantName: 'Participant Name',
                                participantAvatarUrl: '',
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
