import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/outline_section.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../model/contract_details_model.dart';

class ContractSidesItem extends StatelessWidget {
  const ContractSidesItem({super.key, required this.contract});

  final ContractDetailsModel? contract;

  @override
  Widget build(BuildContext context) {
    return OutlinedSection(
      title: AppStrings.partiesSection,
      child: Column(
        children: [
          Card(
            color: AppColors.backgroundLight.withValues(alpha: 0.5),
            margin: EdgeInsets.zero,
            child: ListTile(
              minVerticalPadding: 0,
              dense: true,
              leading: Icon(
                Icons.person_outline,
                color: AppThemeColors.of(context).textFieldTitle,
              ),
              title: Text(
                "${AppStrings.buyerLabel} : ${contract?.tenantName ?? ''}",
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: AppThemeColors.of(context).textFieldTitle,
                ),
              ),
            ),
          ),
          Card(
            color: AppColors.backgroundLight.withValues(alpha: 0.5),
            margin: EdgeInsets.symmetric(vertical: 8.height),
            child: ListTile(
              minVerticalPadding: 0,
              dense: true,
              selected: true,
              selectedColor: AppColors.backgroundLight,
              leading: Icon(
                Icons.person_outline,
                color: AppThemeColors.of(context).textFieldTitle,
              ),
              title: Text(
                "${AppStrings.sellerLabel} : ${contract?.ownerName ?? ''}",
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: AppThemeColors.of(context).textFieldTitle,
                ),
              ),
            ),
          ),
          Card(
            color: AppColors.backgroundLight.withValues(alpha: 0.5),
            margin: EdgeInsets.zero,
            child: ListTile(
              selected: true,
              selectedColor: AppColors.backgroundLight,

              minVerticalPadding: 0,
              dense: true,
              leading: Icon(
                Icons.location_on_outlined,
                color: AppThemeColors.of(context).textFieldTitle,
              ),
              title: Text(
                "${AppStrings.realEstateBrokerLabel} : ${contract?.brokerName ?? ''}",
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: AppThemeColors.of(context).textFieldTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
