import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/responsive.dart';

class RenewContractResult {
  const RenewContractResult({
    required this.newEndDate,
    required this.newPrice,
  });

  final String newEndDate;
  final num newPrice;
}

class RenewContractDialog extends StatefulWidget {
  const RenewContractDialog({
    super.key,
    this.initialEndDate,
    this.initialPrice,
  });

  final String? initialEndDate;
  final num? initialPrice;

  @override
  State<RenewContractDialog> createState() => _RenewContractDialogState();
}

class _RenewContractDialogState extends State<RenewContractDialog> {
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  late final TextEditingController _dateController;
  late final TextEditingController _priceController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _parseDate(widget.initialEndDate);
    _dateController = TextEditingController(
      text: _selectedDate == null ? '' : _apiDateFormat.format(_selectedDate!),
    );
    final price = widget.initialPrice;
    _priceController = TextEditingController(
      text: price == null || price == 0 ? '' : formatPrice(price.toDouble()),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initial = _selectedDate != null && !_selectedDate!.isBefore(today)
        ? _selectedDate!
        : today;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: today,
      lastDate: DateTime(today.year + 20),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _selectedDate = picked;
      _dateController.text = _apiDateFormat.format(picked);
    });
  }

  void _confirm() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (_selectedDate == null || _selectedDate!.isBefore(today)) {
      AppToast(AppStrings.pleaseEnterNewEndDate, isError: true);
      return;
    }
    final price = parsePrice(_priceController.text);
    if (price == null || price <= 0) {
      AppToast(AppStrings.pleaseEnterContractPrice, isError: true);
      return;
    }
    Navigator.of(context).pop(
      RenewContractResult(
        newEndDate: _apiDateFormat.format(_selectedDate!),
        newPrice: price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Dialog(
      backgroundColor: colors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.radius),
        side: BorderSide(color: colors.borderColor),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.width),
      child: Padding(
        padding: EdgeInsets.all(20.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.renewalContract,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 16.height),
            AppTextField(
              isWithTitle: true,
              title: AppStrings.newEndDate,
              hint: 'yyyy-MM-dd',
              controller: _dateController,
              isReadOnly: true,
              suffixIcon: Icons.calendar_today_outlined,
              onTapField: _pickDate,
              onTapSuffixIcon: _pickDate,
            ),
            SizedBox(height: 12.height),
            AppTextField(
              isWithTitle: true,
              title: AppStrings.newContractPrice,
              hint: AppStrings.newContractPrice,
              controller: _priceController,
              textInputType: TextInputType.number,
              isPrice: true,
            ),
            SizedBox(height: 16.height),
            AppButton(
              text: AppStrings.confirm,
              height: 48,
              textSize: 16,
              onTap: _confirm,
            ),
            SizedBox(height: 8.height),
            AppButton(
              text: AppStrings.cancel,
              height: 48,
              textSize: 16,
              isOutline: true,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
