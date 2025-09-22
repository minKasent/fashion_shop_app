// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fashion_shop/core/env/app_config.dart' as _i188;
import 'package:fashion_shop/data/datasource/local/secure_storage.dart'
    as _i280;
import 'package:fashion_shop/di/env_module.dart' as _i948;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i188.AppConfig>(
      () => appModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i188.AppConfig>(
      () => appModule.stagingConfig(),
      registerFor: {_staging},
    );
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
    return this;
  }
}

class _$AppModule extends _i948.AppModule {}
