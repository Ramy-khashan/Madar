import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../../common/chats/chat_navigator.dart';
import '../../controller/business_properties_bloc.dart';
import '../../model/business_property_request_model.dart';
import 'request_action_dialogs.dart';

class BusinessPropertiesPublishedCardWidget extends StatelessWidget {
  const BusinessPropertiesPublishedCardWidget({
    super.key,
    required this.item,
    this.isActionLoading = false,
  });

  final BusinessRequestPublishedPropertyModel item;
  final bool isActionLoading;

  Color _statusColor() {
    switch (item.status.toUpperCase()) {
      case 'ACCEPTED':
      case 'APPROVED':
        return AppColors.successColor;
      case 'REJECTED':
        return AppColors.errorColor;
      default:
        return const Color(0xFFB45309);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final statusColor = _statusColor();
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageItem(
                  item.imageUrl.isEmpty
                      ? AppImages.propertyImage
                      : item.imageUrl,
                  width: 92.width,
                  height: 92.height,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.width,
                              vertical: 4.height,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.radius),
                            ),
                            child: Text(
                              item.statusKey.trans,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(11),
                                fontWeight: FontWeight.w600,
                                fontFamily: AppConstant.appHeaderFont,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.height),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.width,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.width),
                          Expanded(
                            child: Text(
                              item.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.height),
                      Text(
                        '${formatPrice(item.price)} ${AppStrings.currency}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(15),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.primaryBrand,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        item.listingType.transIfExists,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstant.appFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        '${AppStrings.businessPropertiesRequestDateLabel}: ${item.requestDateLabel}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),
            Divider(color: colors.borderColor, height: 1),
            SizedBox(height: 12.height),
            Text(
              AppStrings.applicantDetailsSection,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 10.height),
            Row(
              children: [
                CircleAvatar(
                  radius: 22.width,
                  backgroundColor: colors.primaryBrand.withValues(alpha: 0.15),
                  child: ClipOval(
                    child: item.applicant.imageUrl.isNotEmpty
                        ? ImageItem(
                            item.applicant.imageUrl,
                            width: 44.width,
                            height: 44.width,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_outline,
                            color: colors.primaryBrand,
                            size: 22.width,
                          ),
                  ),
                ),
                SizedBox(width: 10.width),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.applicant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      InkWell(
                        onTap: item.applicant.phone.isEmpty
                            ? null
                            : () => urlLauncher('tel:${item.applicant.phone}'),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 14.width,
                              color: colors.primaryBrand,
                            ),
                            SizedBox(width: 4.width),
                            Flexible(
                              child: Text(
                                item.applicant.phone,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(13),
                                  color: colors.primaryBrand,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 48.width,
                  height: 48.width,
                  child: AppButton(
                    isOutline: true,
                    childImage: AppImages.chatIcon,
                    onTap: () {
                      ChatNavigator.openPrivateChat(
                        context,
                        receiverId: item.applicant.id,
                        participantName: item.applicant.name,
                        participantAvatarUrl: item.applicant.imageUrl,
                      );
                    },
                  ),
                ),
              ],
            ),
            if (item.isRejected && item.rejectReason.isNotEmpty) ...[
              SizedBox(height: 12.height),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.width),
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.rejectReasonTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConstant.appHeaderFont,
                        color: AppColors.errorColor,
                      ),
                    ),
                    SizedBox(height: 4.height),
                    Text(
                      item.rejectReason,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontFamily: AppConstant.appFont,
                        color: colors.textFieldTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (item.isPending) ...[
              SizedBox(height: 12.height),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      childText: AppStrings.businessPropertiesAccept,
                      childIcon: Icons.check,
                      colorBG: AppColors.successColor,
                      isLoading: isActionLoading,
                      onTap: () => _onAccept(context),
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
                      isLoading: isActionLoading,
                      onTap: () => _onReject(context),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _onAccept(BuildContext context) async {
    if (item.id.isEmpty) return;
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AcceptRequestDialog(
        requireLicense: false,
        message: AppStrings.acceptIncomingRequestMessage,
      ),
    );
    if (result == null || !context.mounted) return;
    context.read<BusinessPropertiesBloc>().add(
      BusinessPropertiesAccept(item.id, isIncoming: true),
    );
  }

  Future<void> _onReject(BuildContext context) async {
    if (item.id.isEmpty) return;
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const RejectRequestDialog(),
    );
    if (reason == null || reason.isEmpty || !context.mounted) return;
    context.read<BusinessPropertiesBloc>().add(
      BusinessPropertiesReject(item.id, rejectReason: reason, isIncoming: true),
    );
  }
}
