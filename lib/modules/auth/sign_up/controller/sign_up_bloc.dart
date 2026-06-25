import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/handle_multi_callback.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEvent>((event, emit) {});
    on<SignUpActionEvent>(_signUp);
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static SignUpBloc get(BuildContext context) => BlocProvider.of(context);
  static List<String> roles = [AppConstant.realtor, AppConstant.owner];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _signUp(
    SignUpActionEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      if (!formKey.currentState!.validate()) {
        emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
        return;
      }
      emit(state.copyWith(signUpStatus: RequestStatus.loading));
      final String role = PreferenceUtils().getString(StorageKeys.accountType);
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.register,
        body: {
          "fullName": nameController.text,
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
          "phone": int.parse(phoneController.text.replaceAll('+', '')),
          "role": role,
        },
      );
      await response.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              signUpStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          if (PreferenceUtils().getString(StorageKeys.accountType) ==
              AppConstant.individual) {
            await Future.wait([
              sl.get<HandleMultiCallLocal>().saveLocalData(
                data: successResponse.response['accessToken'],
                keyType: LocalEnumKey.accessToken,
              ),
              sl.get<HandleMultiCallLocal>().saveLocalData(
                data: successResponse.response['refreshToken'],
                keyType: LocalEnumKey.refreshToken,
              ),
              sl.get<PreferenceUtils>().setString(
                StorageKeys.name,
                successResponse.response['user']['fullName'],
              ),
            ]);
          }
          await FlutterSecureStorage().write(
            key: StorageKeys.userID,
            value: successResponse.response['user']['user_id'],
          );
          emit(state.copyWith(signUpStatus: RequestStatus.success));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          signUpStatus: RequestStatus.failed,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
