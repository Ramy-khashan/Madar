import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../common/chats/chat_navigator.dart';
import '../../controller/property_details_bloc.dart';

class ListingActions extends StatelessWidget {
  const ListingActions({super.key, required this.state});

  final PropertyDetailsState state;

  @override
  Widget build(BuildContext context) {
    final existing = state.existingRequest;
    final hasRequest = existing != null && existing.id.isNotEmpty;
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: 560.width,
            text: hasRequest
                ? AppStrings.viewMyRequest
                : AppStrings.sendRequest,
            isLoading: state.submitStatus == RequestStatus.loading,
            onTap: () {
              if (!GuestMode.requireAuth(
                context,
                subtitle: AppStrings.guestFeaturesMessage,
              )) {
                return;
              }
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
