import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/financial_reports_bloc.dart';

Future<void> showAddOtherIncomeDialog(BuildContext context) async {
  final result = await showDialog<({String title, num amount})>(
    context: context,
    builder: (_) => const _AddOtherIncomeDialog(),
  );
  if (result == null || !context.mounted) return;
  FinancialReportsBloc.get(context).add(
    FinancialReportsAddOtherIncome(title: result.title, amount: result.amount),
  );
}

class _AddOtherIncomeDialog extends StatefulWidget {
  const _AddOtherIncomeDialog();

  @override
  State<_AddOtherIncomeDialog> createState() => _AddOtherIncomeDialogState();
}

class _AddOtherIncomeDialogState extends State<_AddOtherIncomeDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final amount = num.tryParse(_amountController.text.trim());
    if (title.isEmpty || amount == null || amount <= 0) {
      AppToast(AppStrings.pleaseCompleteRequiredFields, isError: true);
      return;
    }
    RouterHandler.pop(context, (title: title, amount: amount));
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return AlertDialog(
      backgroundColor: colors.cardBackground,
      title: Text(AppStrings.addOtherIncome),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: _titleController,
              title: AppStrings.otherIncomeTitle,
              hint: AppStrings.otherIncomeTitle,
            ),
            AppTextField(
              controller: _amountController,
              title: AppStrings.otherIncomeAmount,
              hint: AppStrings.otherIncomeAmount,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => RouterHandler.pop(context),
          child: Text(AppStrings.cancel),
        ),
        SizedBox(
          width: 120.width,
          height: 40.height,
          child: AppButton(
            text: AppStrings.add,
            textSize: 14,
            height: 40,
            onTap: _submit,
          ),
        ),
      ],
    );
  }
}
