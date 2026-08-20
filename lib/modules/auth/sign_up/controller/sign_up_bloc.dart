import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/handle_multi_callback.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpActionEvent>(_signUp);
    on<SignUpLicenseFilePicked>(_onLicenseFilePicked);
    on<SignUpLicenseFileCleared>(_onLicenseFileCleared);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static SignUpBloc get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController falLicenseController = TextEditingController();

  bool get isBroker =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.business;
 
  void _onLicenseFilePicked(
    SignUpLicenseFilePicked event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(falLicenseFilePath: event.path));
  }

  void _onLicenseFileCleared(
    SignUpLicenseFileCleared event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(falLicenseFilePath: ''));
  }

  Future<void> _signUp(
    SignUpActionEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      if (!formKey.currentState!.validate()) {
        emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
        return;
      }
      if (isBroker && state.falLicenseFilePath.isEmpty) {
        emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
        return;
      }

      emit(state.copyWith(signUpStatus: RequestStatus.loading, errorMsg: ''));
      final role = PreferenceUtils().getString(StorageKeys.accountType);
      final response = isBroker
          ? await sl.get<ApiConsumer>().postFormData(
              EndPoints.register,
              body: await _brokerFormData(role),
            )
          : await sl.get<ApiConsumer>().post(
              EndPoints.register,
              body: {
                'fullName': nameController.text.trim(),
                'password': passwordController.text,
                'confirmPassword': confirmPasswordController.text,
                'phone': phoneController.text.trim(),
                'role': role,
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
          await _persistSession(successResponse.response);
          emit(state.copyWith(signUpStatus: RequestStatus.success));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          signUpStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  Future<FormData> _brokerFormData(String role) async {
    final path = state.falLicenseFilePath;
    final form = FormData();
    form.fields.addAll([
      MapEntry('fullName', nameController.text.trim()),
      MapEntry('password', passwordController.text),
      MapEntry('confirmPassword', confirmPasswordController.text),
      MapEntry('phone', phoneController.text.trim()),
      MapEntry('role', role.isEmpty ? AppConstant.business : role),
      MapEntry('falLicenseNumber', falLicenseController.text.trim()),
    ]);
    form.files.add(
      MapEntry(
        'falLicenseFile',
        await MultipartFile.fromFile(path, filename: path.split('/').last),
      ),
    );
    return form;
  }

  Future<void> _persistSession(dynamic response) async {
    if (response is! Map) return;
    final data = response['data'] is Map
        ? Map<String, dynamic>.from(response['data'] as Map)
        : Map<String, dynamic>.from(response);
    final user = data['user'] is Map
        ? Map<String, dynamic>.from(data['user'] as Map)
        : <String, dynamic>{};
    final accessToken = data['accessToken'] ?? data['access_token'];
    final refreshToken = data['refreshToken'] ?? data['refresh_token'];
    final userId =
        user['user_id'] ?? user['userId'] ?? user['id'] ?? data['user_id'];

    final saves = <Future<void>>[];
    if (accessToken != null) {
      saves.add(
        sl.get<HandleMultiCallLocal>().saveLocalData(
          data: accessToken.toString(),
          keyType: LocalEnumKey.accessToken,
        ),
      );
    }
    if (refreshToken != null) {
      saves.add(
        sl.get<HandleMultiCallLocal>().saveLocalData(
          data: refreshToken.toString(),
          keyType: LocalEnumKey.refreshToken,
        ),
      );
    }
    if (user['fullName'] != null) {
      saves.add(
        sl.get<PreferenceUtils>().setString(
          StorageKeys.name,
          user['fullName'].toString(),
        ),
      );
    }
    if (userId != null) {
      saves.add(
        const FlutterSecureStorage().write(
          key: StorageKeys.userID,
          value: userId.toString(),
        ),
      );
      saves.add(
        sl.get<PreferenceUtils>().setString(
          StorageKeys.userID,
          userId.toString(),
        ),
      );
    }
    if (saves.isNotEmpty) await Future.wait(saves);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    falLicenseController.dispose();
    return super.close();
  }
}
