import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModule {
  @preResolve
  Future<SharedPreferences> sharedPrefrences() async {
    return await SharedPreferences.getInstance();
  }

  FlutterSecureStorage secureStorage() {
    return FlutterSecureStorage();
  }
}
