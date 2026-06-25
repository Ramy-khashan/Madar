import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/is_scrollable_widget.dart';
import '../../../../core/components/phone_number_field.dart';
import '../../../../core/components/responsive_row_column.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/common_fun.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../../../../core/utils/functions/validate.dart';
import '../../common/header_part.dart';
import '../../common/password_item.dart';
import '../controller/sign_in_bloc.dart';

part 'widgets/sign_in_action.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTable = context.isTablet;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == RequestStatus.success) {
              if (PreferenceUtils().getString(StorageKeys.accountType) ==
                  AppConstant.developer) {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.projectManagerHome,
                  routerType: RouterType.goName,
                );
              } else {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.navbar,
                  routerType: RouterType.goName,
                );
              }
            } else if (state.signInStatus == RequestStatus.failed) {
              AppToast(state.errorMsg);
            }
           },
          builder: (context, state) {
            return Form(
              key: SignInBloc.get(context).formKey,
              autovalidateMode: state.autoValidate,
              child: IsScrollableWidget(
                isScroll: !isTable,
                padding: EdgeInsets.zero,
                child: ResponsiveRowColumn(
                  isTablet: isTable,
                  children: [
                    HeaderPart(isTable: isTable),
                    Expanded(
                      flex: isTable ? 3 : 0,
                      child: Center(
                        child: IsScrollableWidget(
                          isScroll: isTable,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16.width,
                              right: 16.width,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 32.height),
                                Text(
                                  AppStrings.signInTitle,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(24),
                                    fontWeight: FontWeight.w700,
                                    color: AppThemeColors.of(
                                      context,
                                    ).textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.height),
                                Text(
                                  AppStrings.signInSubtitle,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    fontWeight: FontWeight.w500,
                                    color: AppThemeColors.of(
                                      context,
                                    ).textSecondary,
                                  ),
                                ),
                                PhoneNumberField(
                                  initialCountryCode: 'SA',
                                  title: AppStrings.phoneNumber,
                                  hint: AppStrings.enterPhoneNumber,
                                  onChanged: (val) {
                                    SignInBloc.get(
                                      context,
                                    ).phoneController.text = val.completeNumber;
                                  },
                                ),

                                PasswordItem(
                                  title: AppStrings.password,
                                  hint: AppStrings.enterPassword,
                                  validator: (val) =>
                                      Validate.notEmpty(val ?? ""),
                                  controller: SignInBloc.get(
                                    context,
                                  ).passwordController,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.height),
                                    child: TextButton(
                                      onPressed: () {
                                        RouterHandler.navigate(
                                          context,
                                          AppRouterKeys.forgetPassword,
                                        );
                                      },
                                      child: Text(
                                        AppStrings.forgetPassword,
                                        style: TextStyle(
                                          fontSize: context.responsiveFontScale(
                                            14,
                                          ),
                                          color: AppThemeColors.of(
                                            context,
                                          ).textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24.height),
                                if (isTable) const SignInAction(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: isTable ? null : const SignInAction(),
    );
  }
}
