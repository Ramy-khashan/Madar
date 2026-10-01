import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_details/model/property_details_model.dart';
import 'owner_contract_card.dart';

class ContractsSectionWidget extends StatelessWidget {
  const ContractsSectionWidget({super.key, required this.contracts});

  final List<PropertyContract> contracts;

  @override
  Widget build(BuildContext context) {
    if (contracts.isEmpty) return const SizedBox.shrink();
    final colors = AppThemeColors.of(context);
    return Column(
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
          ],
        ),
        SizedBox(height: 12.height),
        ...contracts.map(
          (c) => Padding(
            padding: EdgeInsets.only(bottom: 12.height),
            child: OwnerContractCard(contract: c),
          ),
        ),
      ],
    );
  }
}
