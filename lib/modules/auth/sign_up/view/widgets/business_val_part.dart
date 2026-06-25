import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/translation.dart';
import '../../controller/sign_up_bloc.dart';

class BusinessValPart extends StatelessWidget {
  const BusinessValPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.height),
        Text(
          AppStrings.selectRole,
          style: TextStyle(
            fontSize: context.responsiveFontScale(20),
            color: AppThemeColors.of(context).textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
            fontWeight: FontWeight.w500,
          ),
        ),
        RadioGroup(
          groupValue: null,
          onChanged: (value) {},

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(SignUpBloc.roles.length, (index) {
              final role = SignUpBloc.roles[index];
              return Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  fillColor: WidgetStateProperty.all(AppColors.grey800),
                  value: role,
                  title: Text(
                    role.trans,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(18),
                      color: AppColors.grey800,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        AppTextField(
          title: AppStrings.valLicenseNumber,
          hint: AppStrings.enterValLicenseNumber,
          textInputType: TextInputType.text,
          isWithTitle: true,
        ),
      ],
    );
  }
}
