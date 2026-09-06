import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_file_model.dart';
import 'owner_expense_card.dart';

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
    this.canEdit = true,
    this.onConfirm,
    this.isConfirming = false,
  });

  final List<UnitExpenseModel> expenses;
  final int fileCount;
  final AppThemeColors colors;
  final TextEditingController descController;
  final TextEditingController amountController;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final VoidCallback onPickFiles;
  final bool canEdit;
  final VoidCallback? onConfirm;
  final bool isConfirming;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty && !canEdit) return const SizedBox.shrink();
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
        ...expenses.asMap().entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: 10.height),
            child: OwnerExpenseCard(
              expense: entry.value,
              colors: colors,
              canEdit: canEdit,
              onRemove: () => onRemove(entry.key),
            ),
          ),
        ),
        if (canEdit)
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
                AppTextField(
                  controller: descController,
                  hint: AppStrings.expenseHint,
                  title: AppStrings.unitExpenses,
                  isWithTitle: true,
                ),
                SizedBox(height: 8.height),
                AppTextField(
                  isWithTitle: true,
                  title: AppStrings.listingPrice,
                  hint: AppStrings.enterAmount,
                  controller: amountController,
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 10.height),
                GestureDetector(
                  onTap: onPickFiles,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.height),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.radius),
                      border: Border.all(
                        color: colors.borderColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: colors.primaryBrand,
                          size: 28.width,
                        ),
                        SizedBox(height: 6.height),
                        Text(
                          fileCount > 0
                              ? '${AppStrings.attachExpenseFiles} ($fileCount)'
                              : AppStrings.attachExpenseFileHint,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.height),
                AppButton(
                  onTap: onAdd,
                  childText: AppStrings.addExpenseBtn,
                  childIcon: Icons.add,
                ),
                if (onConfirm != null) ...[
                  SizedBox(height: 10.height),
                  AppButton(
                    onTap: onConfirm,
                    text: AppStrings.confirmAddExpenses,
                    isLoading: isConfirming,
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

