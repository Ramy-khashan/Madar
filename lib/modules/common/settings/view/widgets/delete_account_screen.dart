import 'package:flutter/material.dart';

import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../config/theme/app_theme_colors.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  int _selectedReason = 0;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    final List<String> reasons = [
      AppStrings.deleteAccountReason1,
      AppStrings.deleteAccountReason2,
      AppStrings.deleteAccountReason3,
      AppStrings.deleteAccountReason4,
      AppStrings.deleteAccountReason5,
      AppStrings.deleteAccountReason6,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppAppbar(
        isWithBack: true,
        title: AppStrings.deleteAccount,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.width,
                  vertical: 24.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.deleteAccountReasonTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w600,
                        color: colors.textFieldTitle,
                      ),
                    ),
                    SizedBox(height: 16.height),
                    ...List.generate(reasons.length, (index) {
                      return RadioGroup(
                          groupValue: _selectedReason,

                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedReason = value);
                            }
                          },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.height),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedReason == index
                                  ? AppColors.primary300
                                  : colors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RadioListTile<int>(
                            value: index,
                            activeColor: AppColors.primary300,
                            title: Text(
                              reasons[index],
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textFieldTitle,
                              ),
                            ),
                         
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.width,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.width, 0, 20.width, 24.height),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: dispatch delete account event with reasons[_selectedReason]
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary300,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 52.height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.confirmDelete,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
