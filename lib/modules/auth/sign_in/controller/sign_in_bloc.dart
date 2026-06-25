import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_enums.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/handle_multi_callback.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInEvent>((event, emit) {});
    on<SignInActionEvent>(_signIn);
  }
  static SignInBloc get(BuildContext context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _signIn(SignInActionEvent event, emit) async {
    try {
      if (!formKey.currentState!.validate()) {
        emit(state.copyWith(autoValidate: AutovalidateMode.always));
        return;
      }
      emit(state.copyWith(signInStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().auth(
        EndPoints.login,
        body: {
          'phone': phoneController.text.replaceAll('+', ''),
          'password': passwordController.text,
        },
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
          emit(state.copyWith(signInStatus: RequestStatus.success));
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
}
