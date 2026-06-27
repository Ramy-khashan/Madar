import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/utils/functions/router_handler.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
 import '../../../../../core/components/search_item.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/components/property_card_widget.dart';
 import '../../../../core/model/property_filter_model.dart';
import '../../chats/conversation_detail/model/conversation_info.dart';
import '../../filter/view/filter_sheet_view.dart';
import '../controller/my_wishlist_bloc.dart';

class MyWishlistScreen extends StatelessWidget {
  const MyWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.myWishlistTitle),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<MyWishlistBloc, MyWishlistState>(
              builder: (context, state) {
                // final filter = state is PropertiesLoaded ? state.filter : null;
                return SearchItem(
                  onFilterTap: () async {
       await showFilterSheet(
                      context, onApply: (PropertyFilterModel filter) {  },
                      // initialFilter: filter,
                    );
                   
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<MyWishlistBloc, MyWishlistState>(
                builder: (context, state) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 8.height,
                    ),
                    itemCount: MyWishlistBloc.mockProperties.length,
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
                        mobileLandscape: 420.height,
                        tabletPortrait: 375.height,
                        tabletLandscape: 435.height,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final property = MyWishlistBloc.mockProperties[index];
                      return PropertyCardWidget(
                        property: property,
                        footer: PropertyCardDualFooter(
                          onSendRequest: () {},
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
