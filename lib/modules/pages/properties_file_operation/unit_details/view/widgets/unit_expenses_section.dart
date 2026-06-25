import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';
import '../../controller/unit_details_bloc.dart';

class UnitExpensesSection extends StatelessWidget {
  const UnitExpensesSection({
    super.key,
    required this.expenses,
    required this.bloc,
    required this.colors,
  });

  final List<UnitExpenseModel> expenses;
  final UnitDetailsBloc bloc;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Section title
        Text(
          'مصاريف الشقة',
          style: TextStyle(
            fontSize: context.responsiveFontScale(18),
            fontWeight: FontWeight.w700,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
        SizedBox(height: 12.height),
        Container(
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(20.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Add new row header
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'اضافة مصروف جديد',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.primaryBrand,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4.width),
                  Icon(Icons.add, color: colors.primaryBrand, size: 18.width),
                ],
              ),
              SizedBox(height: 10.height),
              // Input row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: bloc.expenseAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '500',
                        hintStyle: TextStyle(color: colors.textSecondary),
                        filled: true,
                        fillColor: colors.hoverColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.radius),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.width,
                          vertical: 10.height,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: bloc.expenseDescController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: 'مثل : اصلاحات الكهرباء',
                        hintStyle: TextStyle(
                          color: colors.textSecondary,
                          fontSize: context.responsiveFontScale(12),
                        ),
                        filled: true,
                        fillColor: colors.hoverColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.radius),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.width,
                          vertical: 10.height,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Existing expenses list
              if (expenses.isNotEmpty) ...[
                SizedBox(height: 12.height),
                ...expenses.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 6.height),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete_outline,
                              color: AppColors.errorColor, size: 18.width),
                          onPressed: () =>
                              bloc.add(UnitDetailsExpenseRemoved(entry.key)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 8.width),
                        Expanded(
                          child: Text(
                            '${entry.value.amount.toStringAsFixed(0)}  — ${entry.value.description}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(13),
                              color: colors.textFieldTitle,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 12.height),
        // Add expense button
        AppButton(
          onTap: () {
            final desc = bloc.expenseDescController.text.trim();
            final amtStr = bloc.expenseAmountController.text.trim();
            if (desc.isEmpty || amtStr.isEmpty) return;
            final amount = double.tryParse(amtStr) ?? 0;
            bloc.add(UnitDetailsExpenseAdded(description: desc, amount: amount));
          },
          text: 'اضافة مصروف',
          childIcon: Icons.add,
        ),
      ],
    );
  }
}
