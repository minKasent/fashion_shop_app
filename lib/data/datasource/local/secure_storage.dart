import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage(this._secureStorage);

  /// Storage key
  static const String accessTokenKey = 'access-token-key';

  static const String localeKey = 'locale_key';

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: accessTokenKey, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: accessTokenKey);
  }

  Future<void> saveLocale(String locale) async {
    await _secureStorage.write(key: localeKey, value: locale);
  }

  Future<String?> getLocale() async {
    return await _secureStorage.read(key: localeKey);
  }
}
