import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/components/loading_process.dart';
import 'package:madar_app/core/utils/constants/app_enums.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/utils/functions/router_handler.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/property_card_footer_widget.dart';
 import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/components/property_card_widget.dart';
 import '../../chats/conversation_detail/model/conversation_info.dart';
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
            Expanded(
              child: BlocBuilder<MyWishlistBloc, MyWishlistState>(
                builder: (context, state) {
                  return LoadingProcess(
                    status: state.propertiesStatus,
                    errorMsg: state.errorMsg,
                    onTapRefresh: () {
                      MyWishlistBloc.get(context).add(const MyWishlistLoad());
                    },
                    emptyMsg: AppStrings.noSavedProperties,
                    isEmptyList: state.savedProperties.isEmpty,
                    childIsLoader: true,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                        vertical: 8.height,
                      ),
                      itemCount: state.propertiesStatus == RequestStatus.loading
                          ? 10
                          : state.savedProperties.length,
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
                        final property = state.propertiesStatus == RequestStatus.loading
                            ? null
                            : state.savedProperties[index];
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
