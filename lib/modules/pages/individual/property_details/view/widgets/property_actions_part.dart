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
      child: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
        builder: (context, state) {
          if (state.isBrokerRequest) {
            return _BrokerRequestActions(state: state);
          }
          return _ListingActions(state: state);
        },
      ),
    );
  }
}

class _BrokerRequestActions extends StatelessWidget {
  const _BrokerRequestActions({required this.state});

  final PropertyDetailsState state;

  Future<void> _accept(BuildContext context) async {
    final license = await showDialog<String>(
      context: context,
      builder: (_) =>
          AcceptRequestDialog(initialLicense: state.adLicenseNumber ?? ''),
    );
    if (license == null || license.isEmpty || !context.mounted) return;
    context.read<PropertyDetailsBloc>().add(
      PropertyDetailsBrokerAccept(adLicenseNumber: license),
    );
  }

  Future<void> _reject(BuildContext context) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const RejectRequestDialog(),
    );
    if (reason == null || reason.isEmpty || !context.mounted) return;
    context.read<PropertyDetailsBloc>().add(
      PropertyDetailsBrokerReject(rejectReason: reason),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loading = state.actionStatus == RequestStatus.loading;
    return Row(
      children: [
        Expanded(
          child: AppButton(
            childText: AppStrings.businessPropertiesAccept,
            childIcon: Icons.check,
            colorBG: AppColors.successColor,
            isLoading: loading,
            onTap: () => _accept(context),
          ),
        ),
        SizedBox(width: 12.width),
        Expanded(
          child: AppButton(
            childText: AppStrings.businessPropertiesReject,
            childIcon: Icons.close,
            colorBG: AppColors.errorColor.shade100,
            textColor: AppColors.errorColor,
            borderColor: AppColors.errorColor,
            isLoading: loading,
            onTap: () => _reject(context),
          ),
        ),
      ],
    );
  }
}

class _ListingActions extends StatelessWidget {
  const _ListingActions({required this.state});

  final PropertyDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: 560.width,
            text: AppStrings.sendRequest,
            isLoading: state.submitStatus == RequestStatus.loading,
            onTap: () {
              context.read<PropertyDetailsBloc>().add(
                const PropertyDetailsSubmitRequest(),
              );
            },
          ),
        ),
        SizedBox(width: 12.width),
        SizedBox(
          width: 56.height,
          height: 56.height,
          child: AppButton(
            isOutline: true,
            childImage: AppImages.chatIcon,
            onTap: () {
              final property = state.property;
              final receiverId =
                  property?.publisher?.userId ?? property?.owner?.userId ?? '';
              ChatNavigator.openPrivateChat(
                context,
                receiverId: receiverId,
                participantName:
                    property?.publisher?.fullName ??
                    property?.owner?.fullName ??
                    '',
                participantAvatarUrl: property?.publisher?.image,
              );
            },
          ),
        ),
      ],
    );
  }
}
