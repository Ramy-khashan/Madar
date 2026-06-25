import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../core/components/outline_section.dart';
import '../../../../../core/components/responsive_row_column.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../contracts/view/widgets/status_badge_item.dart';
import '../../model/contract_details_model.dart';
import 'contract_info.dart';
import 'contract_sides_item.dart';

part 'contract_header.dart';

class ContractDetailsContentWidget extends StatelessWidget {
  const ContractDetailsContentWidget({super.key, required this.contract});

  final ContractDetailsModel? contract;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet;
    return IsScrollableWidget(
      isScroll: !isTablet,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: ResponsiveRowColumn(
        isTablet: isTablet,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: isTablet ? 1 : 0,
            child: IsScrollableWidget(
              isScroll: isTablet,
              child: Column(
                children: [
                  ContractSummaryCard(contract: contract),
                  SizedBox(height: 16.height),
                  OutlinedSection(
                    title: AppStrings.contractInfoSection,
                    child: Column(
                      children: [
                        IconInfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: AppStrings.startDateLabel,
                          value: contract?.startDate ?? '',
                        ),
                        SizedBox(height: 14.height),
                        IconInfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: AppStrings.endDateLabel,
                          value: contract?.endDate ?? '',
                        ),
                        SizedBox(height: 14.height),
                        if (PreferenceUtils().getString(
                              StorageKeys.accountType,
                            ) ==
                            AppConstant.business) ...[
                          IconInfoRow(
                            icon: Icons.attach_money_outlined,
                            label: AppStrings.contractValueLabel,
                            value:
                                '${formatPrice(contract?.annualRent ?? 0)} ${AppStrings.currency}',
                          ),
                          SizedBox(height: 14.height),
                        ],

                        IconInfoRow(
                          icon: Icons.description_outlined,
                          label: AppStrings.contractTypeLabel,
                          value: ContractDetailsModel.typeLabel(
                            contract?.type ?? 'buy',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.height),
                ],
              ),
            ),
          ),
          Expanded(
            flex: isTablet ? 1 : 0,
            child: IsScrollableWidget(
              isScroll: isTablet,
              child: Column(
                children: [
                  ContractSidesItem(contract: contract),
                  SizedBox(height: 16.height),
                  OutlinedSection(
                    title: AppStrings.termsAndConditions,
                    child: Container(
                      width: double.infinity,
                       alignment: Alignment.topRight,
                      child: SelectableText(
                        contract?.terms ?? '',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appFont,
                          color: AppThemeColors.of(context).textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
