import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../conversation_detail/model/conversation_info.dart';
import '../controller/conversations_bloc.dart';
import '../model/conversation_model.dart';

part 'widget/conversation_item.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppAppbar(
      isWithBack: false,
        title:
          AppStrings.conversationsTitle,

      ),
      body: SafeArea(
        child: Column(
          children: [
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.width),
              child: AppTextField(
                isWithTitle: false,
                hint: AppStrings.search,
                prefixImage: AppImages.searchIcon,
                onChanged: (query) => context.read<ConversationsBloc>().add(
                  ConversationsSearchChanged(query),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  return LoadingProcess(
                    status: state.loadingConversationsStatus,
                    errorMsg: state.errorMsg.isEmpty
                        ? AppStrings.somethingWentWrong
                        : state.errorMsg,
                    onTapRefresh: () => context.read<ConversationsBloc>().add(
                      const ConversationsLoad(),
                    ),
                    childIsLoader: true,
                    emptyMsg: AppStrings.noConversations,
                    isEmptyList: state.filteredConversations.isEmpty,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.height),
                      itemCount:
                          state.loadingConversationsStatus ==
                              RequestStatus.loading
                          ? 12
                          : state.filteredConversations.length,
              
                      separatorBuilder: (_, _) => Divider(
                        color: AppThemeColors.of(context).borderColor,
                        indent: 16.width,
                        endIndent: 16.width,
                        height: 1,
                      ),
                      itemBuilder: (context, i) => ConversationItem(
                        item:
                            state.loadingConversationsStatus ==
                                RequestStatus.loading
                            ? null
                            : state.filteredConversations[i],
                        onTap: () {RouterHandler.navigate(context,AppRouterKeys.conversationDetail,extra: ConversationInfo(
                          conversationId: state.filteredConversations[i].id,
                          participantName: state.filteredConversations[i].title,
                          participantAvatarUrl: state.filteredConversations[i].imageUrl,
                        ));},
                      ),
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
