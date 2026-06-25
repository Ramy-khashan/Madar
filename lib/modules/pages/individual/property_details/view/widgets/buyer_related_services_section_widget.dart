import 'package:flutter/material.dart';
 import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/property_details_buyer_model.dart';

class BuyerRelatedServicesSectionWidget extends StatelessWidget {
  const BuyerRelatedServicesSectionWidget({super.key, required this.property});

  final PropertyBuyerModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.relatedServices,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w700,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 12.height),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.height,
            crossAxisSpacing: 10.width,
            childAspectRatio: .54,
           ),
          children: [
             InstallmentServiceCard(property: property),
             InsuranceServiceCard(property: property),
          ],
        ),
      //  Row(
        
      //     children: [
      //       Expanded(child: InstallmentServiceCard(property: property)),
      //       SizedBox(width: 10.width),
      //       Expanded(child: InsuranceServiceCard(property: property)),
      //     ],
      //   ),
      ],
    );
  }
}

class InstallmentServiceCard extends StatelessWidget {
  const InstallmentServiceCard({super.key, required this.property});

  final PropertyBuyerModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final rentInfo = property?.rentInfo;
    return Container(
      padding: EdgeInsets.all(6.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44.width,
            height: 44.width,
            padding: EdgeInsets.all(10.width),
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8.radius),
              color: colors.primaryBrand.withValues(alpha: 0.25),
            ),
            child: ImageItem(AppImages.rentIcon, width: 20.width),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.height),
            child: Text(
              AppStrings.rentInstallment,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle ,
                size: 16.width,
                color: rentInfo?.isEligible == true
                    ? AppColors.successColor 
                    : colors.textSecondary,
              ),
              SizedBox(width: 4.width),
              Text(
                rentInfo?.isEligible == true
                    ? AppStrings.eligibleInstallment
                    : AppStrings.notInsured,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(10),
                  color: rentInfo?.isEligible == true
                      ? AppColors.successColor 
                      : colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.height),

         Container(
            height: 110.height,

            decoration: BoxDecoration(
            color: colors.hoverColor ,
              borderRadius: BorderRadius.circular(8.radius),
            ),
            child: Column(children:[
               ServiceRow(
            label: AppStrings.annualRentValue,
            value:
                '${rentInfo?.annualRentValue.toInt() ?? 0} ${AppStrings.currency}',
            colors: colors,
            context: context,
          ),
          SizedBox(height: 8.height),
          ServiceRow(
            label: AppStrings.minMonthlyInstallment,
            value:
                '${rentInfo?.minMonthlyInstallment.toInt() ?? 0} ${AppStrings.currency}',
            colors: colors,
            context: context,
          ),
          SizedBox(height: 8.height),
          ServiceRow(
            label: AppStrings.installmentProvidersCount,
            value: '${rentInfo?.providersCount ?? 0}',
            colors: colors,
            context: context,
          ),
            ])),
          SizedBox(height: 16.height),
          AppButton(
            key: Key('installment_service_card_button_${property?.id ?? '1'}'),
            text: AppStrings.viewInstallmentOptions,
            textSize: 14,
            height: 44.height,
            onTap: () => RouterHandler.navigate(
              context,
              AppRouterKeys.rentOptions,
              extra: property?.id ?? '1',
            ),
          ),
        ],
      ),
    );
  }
}

class InsuranceServiceCard extends StatelessWidget {
  const InsuranceServiceCard({super.key, required this.property});

  final PropertyBuyerModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final insInfo = property?.insuranceInfo;
    return Container(
      padding: EdgeInsets.all(6.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44.width,
            height: 44.width,
            padding: EdgeInsets.all(10.width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.radius),
              color: colors.primaryBrand.withValues(alpha: 0.25),
            ),
            child: ImageItem(AppImages.safetyIcon, width: 20.width),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.height),
            child: Text(
              AppStrings.insuranceProperty,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 16.width,
                color: insInfo?.isInsured == true
                    ? AppColors.successColor
                    : colors.textSecondary,
              ),
              Text(
                insInfo?.isInsured == true
                    ? AppStrings.eligibleInstallment
                    : AppStrings.availableForInsurance,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(10),
                  color: insInfo?.isInsured == true
                      ? AppColors.successColor
                      : colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.height),
         
          Container(
            height: 110.height,
            decoration: BoxDecoration(
            color: colors.hoverColor ,
              borderRadius: BorderRadius.circular(8.radius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children:[
              
                   
          ServiceRow(
            label: AppStrings.availableInsuranceTypes,
            value: insInfo?.availableTypes.join(' / ') ?? '',
            colors: colors,
            context: context,
          ),
          SizedBox(height: 8.height),
          ServiceRow(
            label: AppStrings.insuranceCompaniesCount,
            value: '${insInfo?.companiesCount ?? 0}',
            colors: colors,
            context: context,
          ),
             ]),
          ),
          SizedBox(height: 16.height),
          AppButton(
            key: Key('insurance_service_card_button_${property?.id ?? '1'}'),
            text: AppStrings.viewInsuranceOptions,
            textSize: 14,
            height: 44.height,
            onTap: () => RouterHandler.navigate(context,
              AppRouterKeys.insuranceOptions,
              extra: property?.id ?? '1',
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceRow extends StatelessWidget {
  const ServiceRow({
    super.key,
    required this.label,
    required this.value,
    required this.colors,
    required this.context,
  });

  final String label;
  final String value;
  final AppThemeColors colors;
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.height, horizontal: 8.width),
      decoration: BoxDecoration(
        color: colors.hoverColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24.radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: ctx.responsiveFontScale(10),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: ctx.responsiveFontScale(10),
              color: colors.textFieldTitle,
              fontFamily: AppConstant.appFont,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
