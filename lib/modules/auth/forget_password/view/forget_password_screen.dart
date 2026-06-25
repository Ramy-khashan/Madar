import 'package:flutter/material.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/is_scrollable_widget.dart';
import '../../../../core/components/phone_number_field.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';

part 'widgets/forget_password_action.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTable = context.isTablet;
    return Scaffold(
      appBar: AppAppbar(
        title: AppStrings.changePassword,
      ),
      body: SafeArea(
        child: IsScrollableWidget(
          isScroll: !isTable,
          padding: EdgeInsets.only(
            left: 16.width,
            right: 16.width,
            top: 16.height,),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemeColors.of(
                          context,
                        ).primaryBrand.withValues(alpha: 0.1),
                      ),
                      padding: EdgeInsets.all(20.width),
                      child: Row(
                         children: [
                          Icon(
                            Icons.info_outline,
                             color: AppThemeColors.of(context).textFieldTitle,
                          ),
                           Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 8.width),
                              child: Text(
                                AppStrings.forgetPasswordTitle,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                   color:
                                      AppThemeColors.of(context).textFieldTitle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.height),
                 PhoneNumberField(
                    title: AppStrings.phoneNumber,
                    hint: AppStrings.enterPhoneNumber,
                    initialCountryCode: 'SA',
                  ),

                      ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isTable ? null : const ForgetPasswordAction(),
    );
  }
}
