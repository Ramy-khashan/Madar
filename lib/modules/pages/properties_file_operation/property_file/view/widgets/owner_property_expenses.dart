import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_file_model.dart';

class OwnerPropertyExpenses extends StatelessWidget {
  const OwnerPropertyExpenses({
    super.key,
    required this.expenses,
    required this.fileCount,
    required this.colors,
    required this.descController,
    required this.amountController,
    required this.onAdd,
    required this.onRemove,
    required this.onPickFiles,
  });

  final List<UnitExpenseModel> expenses;
  final int fileCount;
  final AppThemeColors colors;
  final TextEditingController descController;
  final TextEditingController amountController;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final VoidCallback onPickFiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Row(
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
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      isWithTitle: false,
                      hint: '500',
                      controller: amountController,
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    flex: 2,
                    child: AppTextField(
                      controller: descController,
                      hint: AppStrings.expenseHint,
                      isWithTitle: false,
                    ),
                  ),
                ],
              ),
              if (expenses.isNotEmpty) ...[
                SizedBox(height: 12.height),
                ...expenses.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 8.height),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.errorColor,
                            size: 18.width,
                          ),
                          onPressed: () => onRemove(entry.key),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 8.width),
                        if ((entry.value.fileUrl ?? '').isNotEmpty) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.radius),
                            child: ImageItem(
                              entry.value.fileUrl!,
                              width: 40.width,
                              height: 40.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8.width),
                        ],
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
              SizedBox(height: 8.height),
              GestureDetector(
                onTap: onPickFiles,
                child: Text(
                  fileCount > 0
                      ? '${AppStrings.attachExpenseFiles} ($fileCount)'
                      : AppStrings.attachExpenseFiles,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.primaryBrand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.height),
        AppButton(
          onTap: onAdd,
          childText: AppStrings.addExpenseBtn,
          childIcon: Icons.add,
        ),
      ],
    );
  }
}
