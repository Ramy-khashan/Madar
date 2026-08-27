import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repository/apis/auth_apis.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc({this.phone = ''}) : super(const ForgetPasswordState()) {
    on<ForgetPasswordPhoneChanged>(_onPhoneChanged);
    on<ForgetPasswordSendOtp>(_onSendOtp);
    on<ForgetPasswordResetSubmitted>(_onResetPassword);
  }

  String phone;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  static ForgetPasswordBloc get(BuildContext context) =>
      BlocProvider.of(context);

  void _onPhoneChanged(
    ForgetPasswordPhoneChanged event,
    Emitter<ForgetPasswordState> emit,
  ) {
    phone = event.phone;
  }

  Future<void> _onSendOtp(
    ForgetPasswordSendOtp event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    if (!(formKey.currentState?.validate() ?? false) || phone.isEmpty) {
      emit(state.copyWith(autoValidate: AutovalidateMode.always));
      return;
    }
    emit(state.copyWith(sendStatus: RequestStatus.loading, errorMsg: ''));
    final result = await AuthApis.sendOtp(phone: phone);
    result.fold(
      (failed) {
        emit(
          state.copyWith(sendStatus: RequestStatus.failed, errorMsg: failed),
        );
      },
      (message) {
        emit(
          state.copyWith(
            sendStatus: RequestStatus.success,
            successMsg: message,
          ),
        );
      },
    );
  }

  Future<void> _onResetPassword(
    ForgetPasswordResetSubmitted event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      emit(state.copyWith(autoValidate: AutovalidateMode.always));
      return;
    }
    emit(state.copyWith(resetStatus: RequestStatus.loading, errorMsg: ''));
    final result = await AuthApis.resetPassword(
      phone: phone,
      newPassword: passwordController.text,
    );
    result.fold(
      (failed) {
        emit(
          state.copyWith(resetStatus: RequestStatus.failed, errorMsg: failed),
        );
      },
      (message) {
        emit(
          state.copyWith(
            resetStatus: RequestStatus.success,
            successMsg: message.isNotEmpty
                ? message
                : AppStrings.passwordResetSuccessfully,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
