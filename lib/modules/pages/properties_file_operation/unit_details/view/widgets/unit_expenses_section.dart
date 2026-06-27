import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madar_app/core/components/image_item.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          AppStrings.unitExpenses,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add new row header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageItem(
                    AppImages.addIcon,
                    color: colors.primaryBrand,
                    width: 20.width,
                    height: 20.width,
                  ),
                  SizedBox(width: 4.width),

                  Text(
                    AppStrings.addNewExpense,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.primaryBrand,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.height),
              // Input row
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      isWithTitle: false,
                      hint: '500',
                      controller: bloc.expenseAmountController,
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    flex: 2,
                    child: AppTextField(
                      controller: bloc.expenseDescController,
                      hint: AppStrings.expenseHint,
                      isWithTitle: false,
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
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.errorColor,
                            size: 18.width,
                          ),
                          onPressed: () =>
                              bloc.add(UnitDetailsExpenseRemoved(entry.key)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 8.width),
                        Expanded(
                          child: Text(
                            '${entry.value.amount.toStringAsFixed(0)}  — ${entry.value.description}',
                            textAlign: TextAlign.start,
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
            bloc.add(
              UnitDetailsExpenseAdded(description: desc, amount: amount),
            );
          },
          childText: AppStrings.addExpenseBtn,
          childIcon: Icons.add,
        ),
      ],
    );
  }
}
