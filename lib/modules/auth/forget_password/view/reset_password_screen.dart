import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/is_scrollable_widget.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/common_fun.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../../../../core/utils/functions/validate.dart';
import '../../common/password_item.dart';
import '../controller/forget_password_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTable = context.isTablet;
    final bloc = ForgetPasswordBloc.get(context);
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.resetStatus != current.resetStatus,
      listener: (context, state) {
        if (state.resetStatus == RequestStatus.success) {
          AppToast(
            state.successMsg.isNotEmpty
                ? state.successMsg
                : AppStrings.passwordResetSuccessfully,
          );
          RouterHandler.navigate(
            context,
            AppRouterKeys.signIn,
            routerType: RouterType.goName,
          );
        } else if (state.resetStatus == RequestStatus.failed) {
          AppToast(state.errorMsg);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppAppbar(title: AppStrings.changePassword),
          body: SafeArea(
            child: Form(
              key: bloc.formKey,
              autovalidateMode: state.autoValidate,
              child: IsScrollableWidget(
                isScroll: !isTable,
                padding: EdgeInsets.only(
                  left: 16.width,
                  right: 16.width,
                  top: 16.height,
                ),
                child: Column(
                  children: [
                    PasswordItem(
                      title: AppStrings.newPassword,
                      hint: AppStrings.enterNewPassword,
                      controller: bloc.passwordController,
                      validator: (val) => Validate.validatePassword(val ?? ''),
                    ),
                    PasswordItem(
                      title: AppStrings.confirmPassword,
                      hint: AppStrings.enterConfirmPassword,
                      controller: bloc.confirmPasswordController,
                      validator: (val) => Validate.validateConfirmPassword(
                        bloc.passwordController.text,
                        val ?? '',
                      ),
                    ),
                    if (isTable) ...[
                      SizedBox(height: 24.height),
                      AppButton(
                        text: AppStrings.confirm,
                        isLoading: state.resetStatus == RequestStatus.loading,
                        onTap: () =>
                            bloc.add(const ForgetPasswordResetSubmitted()),
                        width: 560.width,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: isTable
              ? null
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.width,
                      vertical: 10.height,
                    ),
                    child: AppButton(
                      text: AppStrings.confirm,
                      isLoading: state.resetStatus == RequestStatus.loading,
                      onTap: () =>
                          bloc.add(const ForgetPasswordResetSubmitted()),
                      width: 560.width,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
