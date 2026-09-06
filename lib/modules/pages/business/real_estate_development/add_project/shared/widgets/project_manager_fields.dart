import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/components/phone_number_field.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/validate.dart';
import '../../../../../../auth/common/password_item.dart';

class ProjectManagerFields extends StatelessWidget {
  const ProjectManagerFields({
    super.key,
    required this.nameController,
    required this.passwordController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          isWithTitle: true,
          title: AppStrings.fullName,
          hint: AppStrings.enterFullName,
          controller: nameController,
          textInputType: TextInputType.name,
          validator: (value) => Validate.notEmpty(value ?? ''),
        ),
        PasswordItem(
          title: AppStrings.password,
          hint: AppStrings.enterPassword,
          controller: passwordController,
          validator: (value) => Validate.notEmpty(value ?? ''),
        ),
        SizedBox(height: 10.height),
        PhoneNumberField(
          initialCountryCode: 'SA',
          title: AppStrings.managerPhoneLabel,
          hint: AppStrings.enterPhoneNumber,
          onChanged: (val) {
            phoneController.text = val.completeNumber;
          },
        ),
        SizedBox(height: 4.height),
        Text(
          AppStrings.sendLinkToManagerDesc,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            color: colors.textSecondary,
            fontFamily: AppConstant.appFont,
          ),
        ),
      ],
    );
  }
}
