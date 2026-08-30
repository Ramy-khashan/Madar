import '../constants/app_constant.dart';
import '../constants/storage_keys.dart';
import 'preference_utils.dart';

class AccountRole {
  AccountRole._();

  static String get current =>
      PreferenceUtils().getString(StorageKeys.accountType);

  static bool get isIndividual => current == AppConstant.individual;

  static bool get isBroker => current == AppConstant.business;

  static bool get isOwner => current == AppConstant.owner;

  static bool get isBusiness => isBroker || isOwner;

  static bool get isDeveloper => current == AppConstant.developer;

  static bool isBusinessRole(String role) =>
      role == AppConstant.business || role == AppConstant.owner;

  static Future<void> set(String role) {
    return PreferenceUtils().setString(StorageKeys.accountType, role);
  }
}
