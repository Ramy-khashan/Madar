import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/components/phone_number_field.dart';
import 'package:madar_app/core/utils/functions/responsive.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../controller/settings_bloc.dart';

class UpdatePhoneDialog extends StatelessWidget {
  const UpdatePhoneDialog({
    super.key,
    required this.onChanged,
    required this.isLoading,
    required this.onTap,
  });
  final Function(String) onChanged;

  final bool isLoading;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.updatePhoneNumber,style: TextStyle(fontSize: context.responsiveFontScale(16),fontWeight: FontWeight.w800),),
            SizedBox(height: 16.height),
            PhoneNumberField(
              initialCountryCode: 'SA',
              title: AppStrings.phoneNumber,
              hint: AppStrings.enterPhoneNumber,
              onChanged: (val) => onChanged(val.completeNumber),
            ),
            SizedBox(height: 16.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: AppButton(
                    text: AppStrings.update,
                    isLoading: isLoading,
                    onTap: onTap,
                  ),
                ),
                SizedBox(width: 8.width),

                Expanded(
                  child: AppButton(
                    text: AppStrings.cancel,
                    isOutline: true,
                    borderColor: Colors.red,
                    textColor: Colors.red,

                    colorBG:AppThemeColors.of(context).backgroundPrimary,
                    onTap: () {
                      RouterHandler.pop(context); // Close the dialog
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class UpdateFullNameDialog extends StatelessWidget {
  const UpdateFullNameDialog({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onTap,
  });
  final TextEditingController controller;

  final bool isLoading;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.updateFullName,style: TextStyle(fontSize: context.responsiveFontScale(16),fontWeight: FontWeight.w800),),
            SizedBox(height: 16.height),
            AppTextField(
              hint: AppStrings.fullName,
              controller: controller,
             ),
            SizedBox(height: 16.height),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: AppButton(
                    text: AppStrings.update,
                    isLoading: isLoading,
                    onTap: onTap,
                  ),
                ),
                SizedBox(width: 8.width),
                Expanded(
                  child: AppButton(
                    text: AppStrings.cancel,
                    isOutline: true,
                    borderColor: Colors.red,
                    textColor: Colors.red,
                    colorBG:AppThemeColors.of(context).backgroundPrimary,

                    onTap: () {
                      RouterHandler.pop(context); // Close the dialog
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
