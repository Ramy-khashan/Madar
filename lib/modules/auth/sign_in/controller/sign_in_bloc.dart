import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/account_role.dart';
import '../../../../core/utils/functions/fcm_token_service.dart';
import '../../../../core/utils/functions/handle_multi_callback.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
    : super(SignInState(selectedRole: _initialBusinessRole())) {
    on<SignInActionEvent>(_signIn);
    on<SelectBusinessRoleEvent>(_onSelectRole);
  }

  static SignInBloc get(BuildContext context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController falLicenseController = TextEditingController();

  bool get isBusinessPath => AccountRole.isBusiness;

  bool get isBrokerLogin =>
      isBusinessPath && state.selectedRole == AppConstant.business;

  static String _initialBusinessRole() {
    return AccountRole.isOwner ? AppConstant.owner : AppConstant.business;
  }

  Future<void> _onSelectRole(
    SelectBusinessRoleEvent event,
    Emitter<SignInState> emit,
  ) async {
    await AccountRole.set(event.role);
    emit(state.copyWith(selectedRole: event.role));
  }

  Future<void> _signIn(SignInActionEvent event, emit) async {
    try {
      if (!formKey.currentState!.validate()) {
        emit(state.copyWith(autoValidate: AutovalidateMode.always));
        return;
      }
      emit(state.copyWith(signInStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().auth(
        _loginPath,
        body: _loginBody,
      );
      await res.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              signInStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          final payload = _authPayload(successResponse.response);
          final user = payload['user'] is Map
              ? Map<String, dynamic>.from(payload['user'] as Map)
              : <String, dynamic>{};
          final role = (user['role'] ?? state.selectedRole).toString();
          await Future.wait([
            sl.get<HandleMultiCallLocal>().saveLocalData(
              data: '${payload['accessToken'] ?? ''}',
              keyType: LocalEnumKey.accessToken,
            ),
            sl.get<HandleMultiCallLocal>().saveLocalData(
              data: '${payload['refreshToken'] ?? ''}',
              keyType: LocalEnumKey.refreshToken,
            ),
            sl.get<PreferenceUtils>().setString(
              StorageKeys.name,
              '${user['fullName'] ?? ''}',
            ),
            sl.get<PreferenceUtils>().setString(StorageKeys.accountType, role),
            sl.get<PreferenceUtils>().setString(
              StorageKeys.image,
              '${user['image'] ?? ''}',
            ),
            sl.get<PreferenceUtils>().setString(
              StorageKeys.userID,
              (user['user_id'] ?? user['userId'] ?? user['id'] ?? '')
                  .toString(),
            ),
            sl.get<PreferenceUtils>().setBool(StorageKeys.isGuest, false),
          ]);
          FcmTokenService.instance.syncToken();
          emit(
            state.copyWith(signInStatus: RequestStatus.success, role: role),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          signInStatus: RequestStatus.failed,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  String get _loginPath {
    if (!isBusinessPath) return EndPoints.login;
    return isBrokerLogin ? EndPoints.loginBroker : EndPoints.loginOwner;
  }

  Map<String, dynamic> get _loginBody {
    if (isBrokerLogin) {
      return {
        'falLicenseNumber': falLicenseController.text.trim(),
        'password': passwordController.text,
      };
    }
    return {
      'phone': phoneController.text,
      'password': passwordController.text,
    };
  }

  Map<String, dynamic> _authPayload(dynamic response) {
    if (response is! Map) return {};
    final map = Map<String, dynamic>.from(response);
    if (map['data'] is Map) {
      return Map<String, dynamic>.from(map['data'] as Map);
    }
    return map;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    falLicenseController.dispose();
    return super.close();
  }
}
