// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fashion_shop/core/env/app_config.dart' as _i188;
import 'package:fashion_shop/core/logging/app_logger.dart' as _i673;
import 'package:fashion_shop/core/logging/console_app_logger.dart' as _i1049;
import 'package:fashion_shop/data/core/inteterceptors.dart' as _i341;
import 'package:fashion_shop/data/datasource/local/secure_storage.dart'
    as _i280;
import 'package:fashion_shop/di/env_module.dart' as _i948;
import 'package:fashion_shop/di/third_party_module.dart' as _i252;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.sharedPrefrences(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.singleton<_i188.AppConfig>(
      () => appModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i188.AppConfig>(
      () => appModule.stagingConfig(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i673.AppLogger>(() => _i1049.ConsoleAppLogger());
    gh.singleton<String>(
      () => appModule.devBaseUrl(gh<_i188.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_dev},
    );
    gh.singleton<String>(
      () => appModule.stagingBaseUrl(gh<_i188.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_staging},
    );
    gh.singleton<_i280.SecureStorage>(
      () => _i280.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i188.AppConfig>(
      () => appModule.prodConfig(),
      registerFor: {_prod},
    );
    gh.singleton<String>(
      () => appModule.prodBaseUrl(gh<_i188.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_prod},
    );
    gh.lazySingleton<_i341.NetworkInterceptor>(
      () => _i341.NetworkInterceptor(
        gh<_i280.SecureStorage>(),
        gh<_i673.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => thirdPartyModule.dio(
        gh<_i188.AppConfig>(),
        gh<String>(instanceName: 'baseUrl'),
        gh<_i341.NetworkInterceptor>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i252.ThirdPartyModule {}

class _$AppModule extends _i948.AppModule {}
