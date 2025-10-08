// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:fashion_shop/core/logging/app_logger.dart' as _i673;
import 'package:fashion_shop/core/logging/console_app_logger.dart' as _i1049;
import 'package:fashion_shop/di/third_party_module.dart' as _i252;
import 'package:fashion_shop/repositories/auth_repository.dart' as _i840;
import 'package:fashion_shop/screens/setting/cubit/setting_cubit.dart' as _i325;
import 'package:fashion_shop/services/remote/firebase_service.dart' as _i488;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.sharedPrefrences(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => thirdPartyModule.auth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => thirdPartyModule.firestore);
    gh.lazySingleton<_i673.AppLogger>(() => _i1049.ConsoleAppLogger());
    gh.lazySingleton<_i488.FirebaseService>(
      () => _i488.FirebaseService(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i673.AppLogger>(),
      ),
    );
    gh.factory<_i325.SettingCubit>(
      () => _i325.SettingCubit(
        gh<_i488.FirebaseService>(),
        gh<_i673.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i840.AuthRepository>(
      () => _i840.AuthRepository(
        gh<_i488.FirebaseService>(),
        gh<_i673.AppLogger>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i252.ThirdPartyModule {}
