import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_textfield.dart';
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
import '../../common/business_role_toggle.dart';
import '../../common/header_part.dart';
import '../../common/password_item.dart';
import '../controller/sign_up_bloc.dart';
import 'widgets/business_val_part.dart';

part 'widgets/sign_up_action.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTable = context.isTablet;

    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.signUpStatus == RequestStatus.success) {
            if (PreferenceUtils().getString(StorageKeys.accountType) ==
                AppConstant.business) {
              // RouterHandler.navigate(
              //   context,
              //   AppRouterKeys.subscriptionPlans,
              //   routerType: RouterType.goName,
              // );
                RouterHandler.navigate(
                context,
                AppRouterKeys.navbar,
                routerType: RouterType.goName,
              );
            } else {
              RouterHandler.navigate(
                context,
                AppRouterKeys.navbar,
                routerType: RouterType.goName,
              );
            }
          } else if (state.signUpStatus == RequestStatus.failed) {
            AppToast(state.errorMsg);
          }
        },
        builder: (context, state) {
          return Form(
            autovalidateMode: state.autoValidateMode,
            key: SignUpBloc.get(context).formKey,
            child: SafeArea(
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
                              top: 30.height,
                            ),
                            child: SafeArea(
                              top: false,
                              left: isTable ? false : true,
                              right: isTable ? false : true,

                              child: Column(
                                children: [
                                  AppTextField(
                                    title: AppStrings.fullName,
                                    hint: AppStrings.enterFullName,
                                    isWithTitle: true,
                                    textInputType: TextInputType.name,
                                    controller: SignUpBloc.get(
                                      context,
                                    ).nameController,
                                    validator: (p0) =>
                                        Validate.notEmpty(p0 ?? ''),
                                  ),

                                  PhoneNumberField(
                                    initialCountryCode: 'SA',
                                    title: AppStrings.phoneNumber,
                                    hint: AppStrings.enterPhoneNumber,
                                    onChanged: (value) {
                                      SignUpBloc.get(
                                            context,
                                          ).phoneController.text =
                                          value.completeNumber;
                                    },
                                  ),
                                  if (SignUpBloc.get(context).isBusinessPath) ...[
                                    SizedBox(height: 8.height),
                                    BusinessRoleRadios(
                                      selectedRole: state.selectedRole,
                                      onChanged: (role) => SignUpBloc.get(
                                        context,
                                      ).add(SignUpSelectRoleEvent(role)),
                                    ),
                                    SizedBox(height: 8.height),
                                  ],
                                  if (SignUpBloc.get(context).isBroker)
                                    const BusinessValPart(),
                                  PasswordItem(
                                    title: AppStrings.password,
                                    hint: AppStrings.enterPassword,
                                    controller: SignUpBloc.get(
                                      context,
                                    ).passwordController,
                                    validator: (p0) =>
                                        Validate.validatePassword(p0 ?? ''),
                                  ),
                                  PasswordItem(
                                    title: AppStrings.confirmPassword,
                                    hint: AppStrings.enterConfirmPassword,
                                    controller: SignUpBloc.get(
                                      context,
                                    ).confirmPasswordController,
                                    validator: (value) =>
                                        Validate.validateConfirmPassword(
                                          SignUpBloc.get(
                                            context,
                                          ).passwordController.text,
                                          value ?? '',
                                        ),
                                  ),
                                  SizedBox(height: 24.height),
                                  if (isTable) const SignUpAction(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: isTable ? null : const SignUpAction(),
    );
  }
}
