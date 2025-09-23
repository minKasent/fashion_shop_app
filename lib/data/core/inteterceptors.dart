import 'package:dio/dio.dart';
import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:injectable/injectable.dart';

import '../datasource/local/secure_storage.dart';

@lazySingleton
class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._secureStorage, this._appLogger);

  final SecureStorage _secureStorage;
  final AppLogger _appLogger;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    _appLogger.t(
      'REQ ${options.method} ${options.uri}',
      meta: {
        'headers': options.headers,
        'query': options.queryParameters,
        'data': options.data,
      },
    );

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _appLogger.t(
      'RES [${response.statusCode}] ${response.requestOptions.uri}',
      meta: {'data': response.data},
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _appLogger.e(
      'ERR [${err.response?.statusCode}] ${err.response?.requestOptions.uri}',
      meta: {'data': err.response?.data, 'type': err.type.name},
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
