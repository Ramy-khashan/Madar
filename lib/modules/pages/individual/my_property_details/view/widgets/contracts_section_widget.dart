import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../property_details/model/property_details_model.dart';

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
        ...contracts.map((c) => Padding(
          padding: EdgeInsets.only(bottom: 12.height),
          child: _OwnerContractCard(contract: c),
        )),
      ],
    );
  }
}

class _OwnerContractCard extends StatelessWidget {
  const _OwnerContractCard({required this.contract});

  final PropertyContract contract;

  String _date(String? raw) {
    final parsed = DateTime.tryParse(raw ?? '');
    if (parsed == null) return raw ?? '';
    final local = parsed.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final name = contract.name ?? contract.buyerName ?? '';
    final start = _date(contract.startDate);
    final end = _date(contract.endDate);
    final priceLabel = contract.isRent
        ? AppStrings.monthlyRent
        : AppStrings.listingPrice;
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
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: contract.isActive
                      ? colors.primaryBrand.withValues(alpha: 0.1)
                      : colors.borderColor,
                  borderRadius: BorderRadius.circular(20.radius),
                ),
                child: Text(
                  (contract.status ?? '').transIfExists,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: contract.isActive
                        ? colors.primaryBrand
                        : colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (contract.price != null) ...[
            SizedBox(height: 8.height),
            Text(
              '$priceLabel: ${formatPrice(contract.price!.toDouble())} ${AppStrings.currency}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.primaryBrand,
                fontFamily: AppConstant.appHeaderFont,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (start.isNotEmpty) ...[
            SizedBox(height: 4.height),
            Text(
              AppStrings.contractDateRange(start, end),
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ],
          if ((contract.id ?? '').isNotEmpty) ...[
            SizedBox(height: 12.height),
            AppButton(
              onTap: () => RouterHandler.navigate(
                context,
                AppRouterKeys.contractDetails,
                extra: contract.id,
              ),
              childText: AppStrings.viewContract,
            ),
          ],
        ],
      ),
    );
  }
}
