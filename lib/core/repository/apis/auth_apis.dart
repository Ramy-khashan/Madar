import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../config/router/app_router_keys.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_enums.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/constants/storage_keys.dart';
import '../../utils/functions/handle_multi_callback.dart';
import '../../utils/functions/preference_utils.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/router_handler.dart';
import '../../utils/functions/service_locator.dart';

class AuthApis {
  AuthApis._();

  static Future<Either<String, String>> sendOtp({required String phone}) async {
    try {
      final response = await sl.get<ApiConsumer>().auth(
        EndPoints.otpSend,
        body: {'phone': phone},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /otp/send: ${success.response}');
        return Right(_messageFrom(success.response));
      });
    } catch (e) {
      printState('sendOtp error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, String>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().auth(
        EndPoints.otpVerify,
        body: {'phone': phone, 'code': code},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /otp/verify: ${success.response}');
        return Right(_messageFrom(success.response));
      });
    } catch (e) {
      printState('verifyOtp error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, String>> resetPassword({
    required String phone,
    required String newPassword,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().auth(
        EndPoints.otpResetPassword,
        body: {'phone': phone, 'newPassword': newPassword},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /otp/reset-password: ${success.response}');
        return Right(_messageFrom(success.response));
      });
    } catch (e) {
      printState('resetPassword error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, Unit>> saveFcmToken({
    required String fcmToken,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.fcmToken,
        body: {'fcmToken': fcmToken},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /auth/save-fcm-token: ${success.response}');
        return const Right(unit);
      });
    } catch (e) {
      printState('saveFcmToken error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, String>> logout() async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.logout,
        body: <String, dynamic>{},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /auth/logout: ${success.response}');
        return Right(_messageFrom(success.response));
      });
    } catch (e) {
      printState('logout error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static const List<String> deleteAccountReasons = [
    'NOT_USING_APP',
    'ANOTHER_ACCOUNT',
    'APP_ISSUES',
    'PRIVACY_CONCERNS',
    'PREFER_NOT_TO_SAY',
    'OTHER',
  ];

  static Future<Either<String, String>> deleteAccount({
    required String reason,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().delete(
        EndPoints.profile,
        body: {'reason': reason},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('DELETE /users/profile: ${success.response}');
        return Right(_messageFrom(success.response));
      });
    } catch (e) {
      printState('deleteAccount error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<void> logoutAndGoToChooseAccount(BuildContext context) async {
    final isGuest = sl.get<PreferenceUtils>().getBool(StorageKeys.isGuest);
    if (!isGuest) {
      await logout();
    }
    await clearSession();
    if (!context.mounted) return;
    RouterHandler.navigate(
      context,
      AppRouterKeys.chooseAccount,
      routerType: RouterType.pushReplacementNamed,
    );
  }

  static Future<void> clearSession() async {
    await sl.get<HandleMultiCallLocal>().clear();
    final prefs = sl.get<PreferenceUtils>();
    await Future.wait([
      prefs.clear(StorageKeys.userID),
      prefs.clear(StorageKeys.name),
      prefs.clear(StorageKeys.image),
      prefs.clear(StorageKeys.accountType),
      prefs.clear(StorageKeys.isGuest),
    ]);
  }

  static String _messageFrom(Map<String, dynamic> response) {
    final message = response['message']?.toString().trim() ?? '';
    return message.isNotEmpty ? message : AppStrings.somethingWentWrong;
  }
}
