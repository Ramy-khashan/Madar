import 'package:flutter/material.dart';
  import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../model/property_details_model.dart';

class ContractsSectionWidget extends StatelessWidget {
  const ContractsSectionWidget({super.key, required this.contracts});

  final List<ContractModel> contracts;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.contracts,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              GestureDetector(
                key: Key('view_all_contracts_button'),
                onTap: () {},
                child: Text(
                  AppStrings.viewAllContracts,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.primaryBrand,
                    decoration: TextDecoration.underline,
                    decorationColor: colors.primaryBrand,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          ...contracts.map((c) => ContractCardWidget(contract: c)),
        ],
      ),
    );
  }
}

class ContractCardWidget extends StatelessWidget {
  const ContractCardWidget({super.key, required this.contract});

  final ContractModel contract;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final isActive = contract.status == 'active';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              contract.tenantName,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 4.height,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? colors.primaryBrand.withValues(alpha: 0.1)
                    : colors.borderColor,
                borderRadius: BorderRadius.circular(20.radius),
              ),
              child: Text(
                contract.status.trans,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: isActive ? colors.primaryBrand : colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.height),
        // Text(
        //   '${AppStrings.monthlyRent}: ${contract.monthlyRent.toInt()} ${AppStrings.currency}',
        //   style: TextStyle(
        //     fontSize: context.responsiveFontScale(16),
        //     color: colors.primaryBrand,
        //     fontFamily: AppConstant.appHeaderFont,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // SizedBox(height: 4.height),
         Text(
          'من ${contract.startDate} الي ${contract.endDate}',
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            color: colors.textSecondary,
            fontFamily: AppConstant.appFont,
          ),
        ),
        SizedBox(height: 12.height),
        AppButton(
          key: Key('view_contract_button_${contract.id}'),
          onTap: () => RouterHandler.navigate(context,
            AppRouterKeys.contractDetails,
            extra: contract.id,
          ),
          childText: AppStrings.viewContract,
        ),
      ],
    );
  }
}
