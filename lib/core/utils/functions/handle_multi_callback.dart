import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_enums.dart';
import '../constants/storage_keys.dart';

class HandleMultiCallLocal {
  static const _storage = FlutterSecureStorage();

  String? _accessToken;
  String? _refreshToken;

  Future<void> saveLocalData({
    required String? data,
    required LocalEnumKey keyType,
  }) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken = data;
        await _storage.write(key: StorageKeys.accessToken, value: data);
        break;
      case LocalEnumKey.refreshToken:
        _refreshToken = data;
        await _storage.write(key: StorageKeys.refreshToken, value: data);
        break;
    }
  }

  Future<String?> getLocalData({required LocalEnumKey keyType}) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken ??= await _storage.read(key: StorageKeys.accessToken);
        return _accessToken;
      case LocalEnumKey.refreshToken:
        _refreshToken ??= await _storage.read(key: StorageKeys.refreshToken);
        return _refreshToken;
    }
  }

  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;

    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
}
