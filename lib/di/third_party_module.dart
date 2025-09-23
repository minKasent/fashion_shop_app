import 'package:dio/dio.dart';
import 'package:fashion_shop/core/env/app_config.dart';
import 'package:fashion_shop/data/core/dio_logger.dart';
import 'package:fashion_shop/data/core/inteterceptors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModule {
  @lazySingleton
  Dio dio(
    AppConfig appConfig,
    @Named('baseUrl') String baseUrl,
    NetworkInterceptor networkInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(prettyDioLoggerInterceptor());
    dio.interceptors.addAll([networkInterceptor]);

    return dio;
  }

  @preResolve
  Future<SharedPreferences> sharedPrefrences() async {
    return await SharedPreferences.getInstance();
  }

  FlutterSecureStorage secureStorage() {
    return FlutterSecureStorage();
  }
}
