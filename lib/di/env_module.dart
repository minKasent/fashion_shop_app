import 'package:fashion_shop/core/env/app_config.dart';
import 'package:fashion_shop/core/env/flavor.dart';
import 'package:injectable/injectable.dart';

const dev = Environment('dev');
const staging = Environment('staging');
const prod = Environment('prod');

@module
abstract class AppModule {
  @dev
  @Singleton()
  AppConfig devConfig() =>
      AppConfig(flavor: Flavor.dev, baseUrl: 'https://api.dev.com');
  @staging
  @Singleton()
  AppConfig stagingConfig() =>
      AppConfig(flavor: Flavor.staging, baseUrl: 'https://api.staging.com');
  @prod
  @Singleton()
  AppConfig prodConfig() =>
      AppConfig(flavor: Flavor.prod, baseUrl: 'https://api.prod.com');

  /// baseUrl for each environment with @Named to inject into Dio/Retrofit
  @dev
  @Singleton()
  @Named('baseUrl')
  String devBaseUrl(AppConfig appConfig) => appConfig.baseUrl;

  @staging
  @Singleton()
  @Named('baseUrl')
  String stagingBaseUrl(AppConfig appConfig) => appConfig.baseUrl;

  @prod
  @Singleton()
  @Named('baseUrl')
  String prodBaseUrl(AppConfig appConfig) => appConfig.baseUrl;
}
