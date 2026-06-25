part of 'property_details_content_widget.dart';

class PropertyActionsPart extends StatelessWidget {
  const PropertyActionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.radius),
        border: Border.all(color: AppThemeColors.of(context).borderColor),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),

      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
              builder: (context, state) {
                return AppButton(
                  width: 560.width,
                  text: AppStrings.sendRequest,
                  isLoading: state.submitStatus == RequestStatus.loading,
                  onTap: () {
                    context.read<PropertyDetailsBloc>().add(
                      const PropertyDetailsSubmitRequest(),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: 12.width),

          SizedBox(
            width: 56.height,
            height: 56.height,
            child: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
              builder: (context, state) {
                return AppButton(
                  isOutline: true,
                  // childText: AppStrings.chat,
                  childImage: AppImages.chatIcon,
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.conversationDetail,

                      extra: ConversationInfo(
                        conversationId: '123',
                        participantName: 'Property Owner Name',
                        participantAvatarUrl: '',
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
