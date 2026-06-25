import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../controller/financial_reports_bloc.dart';
import '../../model/financial_report_models.dart';
import 'shared/financial_property_row.dart';

class FinancialReportsRevenueTabWidget extends StatelessWidget {
  const FinancialReportsRevenueTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
      buildWhen: (p, c) => p.rentItems != c.rentItems,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // إيجارات مدفوعة
              _RevenueSection(
                title: AppStrings.paidRentsLabel,
                trailing:   'المجموع ٦،٠٠٠ ${AppStrings.currency}',
               
                colors: colors,
                child: Column(
                  children: state.rentItems
                      .map(
                        (item) => FinancialPropertyRow(
                          date: item.date,
                          status: item.status,
                          name: item.name,
                          amount: '${item.amount} ${AppStrings.currency}',
                          paid: item.paid,
                          colors: colors,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 12.height),
              // دفعات جزئية
              _PartialPaymentCard(colors: colors, rentItems: state.rentItems),
              SizedBox(height: 12.height),
              // مصادر دخل أخرى
              _OtherIncomeCard(colors: colors),
            ],
          ),
        );
      },
    );
  }
}

class _RevenueSection extends StatelessWidget {
  const _RevenueSection({
    required this.title,
    required this.trailing,
    required this.colors,
    required this.child,
  });

  final String title;
  final String trailing;
  final AppThemeColors colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
              ),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          child,
        ],
      ),
    );
  }
}

class _PartialPaymentCard extends StatelessWidget {
  const _PartialPaymentCard({required this.colors, required this.rentItems});

  final AppThemeColors colors;
  final List<FinancialRentItem> rentItems;

  @override
  Widget build(BuildContext context) {
    final partials = rentItems.where((i) => !i.paid).toList();
    return OutlinedSection(
      title: AppStrings.partialPaymentsLabel,
      child: Container(
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: AppColors.rate.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(color: AppColors.rate.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             
            SizedBox(height: 10.height),
            ...partials.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.height),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          item.status,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: AppColors.rate,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${item.amount} ${AppStrings.currency}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                        ),Text(
                          'متبقي: ١٥٬٠٠٠ ${AppStrings.currency}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w600,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtherIncomeCard extends StatelessWidget {
  const _OtherIncomeCard({required this.colors});

  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.otherIncomeSources,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
              ),
              Text(
                'المجموع ٦،٠٠٠ ${AppStrings.currency}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textFieldTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.additionalServicesFees,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '٥،٠٠٠ ${AppStrings.currency}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: AppColors.secondBrand,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
