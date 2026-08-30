import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../business_home/controller/business_home_bloc.dart'
    show BusinessHomeBloc, RequestsLoad;
import '../../../../individual/property_details/model/property_details_route_args.dart';
import '../../controller/business_properties_bloc.dart';
import '../../model/business_property_request_model.dart';
import 'request_action_dialogs.dart';

class BusinessPropertiesRequestCardWidget extends StatelessWidget {
  const BusinessPropertiesRequestCardWidget({
    super.key,
    this.item,
    this.isWithActionButtons = true,
    this.isActionLoading = false,
  });
  final bool isWithActionButtons;
  final bool isActionLoading;
  final BusinessPropertyRequestModel? item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _openDetails(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property image
                    Center(
                      child: ImageItem(
                        item?.image ?? '',
                        width: 83.width,
                        height: 71.height,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 12.width),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Expanded(
                                child: Text(
                                  item?.title ?? 'Request Title',
                                  textAlign: TextAlign.start,
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
                                  color: Colors.amber.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(
                                    20.radius,
                                  ),
                                ),
                                child: Text(
                                  (item?.status ?? 'PENDING').transIfExists,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(12),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppConstant.appHeaderFont,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Title
                          // Location
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: colors.textSecondary,
                              ),
                              SizedBox(width: 4.width),

                              Text(
                                item?.locationLabel.isNotEmpty == true
                                    ? item!.locationLabel
                                    : '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                  color: colors.textSecondary,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            ],
                          ),
                          // Individual
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16.width,
                                color: colors.textSecondary,
                              ),
                              Expanded(
                                child: Text(
                                  ' ${item?.owner ?? 'Unknown'}',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: colors.textSecondary,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              ),
                              // Date
                              ImageItem(
                                AppImages.updateIcon,
                                color: colors.textSecondary,
                              ),
                              Text(
                                item?.createdAtLabel ?? '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                  color: colors.textSecondary,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isWithActionButtons && (item?.isPending ?? true)) ...[
              SizedBox(height: 12.height),
              // Buttons
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
    final requestId = item?.requestId ?? '';
    if (requestId.isEmpty) return;
    final license = await showDialog<String>(
      context: context,
      builder: (_) =>
          AcceptRequestDialog(initialLicense: item?.adLicenseNumber ?? ''),
    );
    if (license == null || license.isEmpty || !context.mounted) return;
    context.read<BusinessPropertiesBloc>().add(
      BusinessPropertiesAccept(requestId, adLicenseNumber: license),
    );
  }

  Future<void> _onReject(BuildContext context) async {
    final requestId = item?.requestId ?? '';
    if (requestId.isEmpty) return;
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const RejectRequestDialog(),
    );
    if (reason == null || reason.isEmpty || !context.mounted) return;
    context.read<BusinessPropertiesBloc>().add(
      BusinessPropertiesReject(requestId, rejectReason: reason),
    );
  }

  Future<void> _openDetails(BuildContext context) async {
    final propertyId = item?.propertyId ?? '';
    if (propertyId.isEmpty) return;
    final result = await RouterHandler.navigate(
      context,
      AppRouterKeys.propertyDetails,
      extra: PropertyDetailsRouteArgs(
        propertyId: propertyId,
        brokerRequestId: item?.requestId,
        adLicenseNumber: item?.adLicenseNumber,
      ),
    );
    if (result != true || !context.mounted) return;
    try {
      context.read<BusinessPropertiesBloc>().add(
        const BusinessPropertiesLoad(),
      );
    } catch (_) {}
    try {
      context.read<BusinessHomeBloc>().add(const RequestsLoad());
    } catch (_) {}
  }
}
