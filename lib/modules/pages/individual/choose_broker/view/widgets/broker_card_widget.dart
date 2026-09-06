import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/choose_broker_bloc.dart';
import '../../model/broker_model.dart';
import 'agent_details_row_item.dart';

class BrokerCardWidget extends StatelessWidget {
  const BrokerCardWidget({super.key, this.broker});

  final BrokerModel? broker;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 52.width,
                height: 52.width,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: colors.primaryBrand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                child: ImageItem(
                  broker?.imageUrl ?? AppImages.agentImage,
                  width: 52.width,
                  height: 52.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.width),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            broker?.name ?? 'Broker Name',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.width),
                        const ImageItem(AppImages.safetyIcon),
                      ],
                    ),
                    SizedBox(height: 2.height),
                    Text(
                      '${AppStrings.licensePrefix}: ${broker?.licenseNumber ?? 'License Number'}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.height),
                    Row(
                      children: [
                        Text(
                          '${broker?.propertiesCount ?? 0} ${AppStrings.propertiesCountSuffix}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textSecondary,
                          ),
                        ),
                        // Text(
                        //   '  •  ',
                        //   style: TextStyle(
                        //     color: colors.textSecondary,
                        //     fontSize: context.responsiveFontScale(14),
                        //   ),
                        // ),
                        // Text(
                        //   '(${broker?.reviewsCount ?? 0})',
                        //   style: TextStyle(
                        //     fontSize: context.responsiveFontScale(14),
                        //     fontFamily: AppConstant.appHeaderFont,
                        //     color: colors.textSecondary,
                        //   ),
                        // ),
                        // Text(
                        //   ' ${broker?.rating ?? 0} ',
                        //   style: TextStyle(
                        //     fontSize: context.responsiveFontScale(14),
                        //     fontFamily: AppConstant.appHeaderFont,
                        //     fontWeight: FontWeight.w700,
                        //     color: colors.textFieldTitle,
                        //   ),
                        // ),
                        // SizedBox(width: 2.width),
                        // Icon(Icons.star, size: 14.width, color: AppColors.rate),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          AgentDetailsRow(
            icon: AppImages.locationIcon,
            text: broker?.location ?? 'Location not available',
            colors: colors,
          ),
          // SizedBox(height: 4.height),
          // AgentDetailsRow(
          //   icon: AppImages.experienceIcon,
          //   text:
          //       '${AppStrings.experiencePrefix} ${broker?.experienceYears ?? 0} ${AppStrings.experienceSuffix}',
          //   colors: colors,
          // ),
          SizedBox(height: 4.height),
          AgentDetailsRow(
            icon: AppImages.occupancyIcon,
            text:
                '${AppStrings.commissionPrefix} ${broker?.commissionPercent ?? 0}%',
            colors: colors,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.height),
            child: Text(
              broker?.description ?? 'Description not available',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontFamily: AppConstant.appFont,
                color: colors.textSecondary,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: AppStrings.selectBroker,
                  onTap: () => context.read<ChooseBrokerBloc>().add(
                    ChooseBrokerSelect(broker?.id ?? ''),
                  ),
                ),
              ),
              SizedBox(width: 10.width),
              Expanded(
                child: AppButton(
                  text: AppStrings.viewProfile,
                  isOutline: true,
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.brokerProperties,
                      extra: broker?.userId ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
