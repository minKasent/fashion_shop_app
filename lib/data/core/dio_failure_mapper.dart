import 'package:dio/dio.dart';
import 'package:fashion_shop/domain/core/failures.dart';

/// Extracts the server message from the data
/// which is response.data (String/Map/Whatever)
String? extractServerMessage(dynamic data) {
  try {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map<String, dynamic>) {
      /// Key is message or msg or error or error_message
      /// -> this is depending on the server response
      final message = data['message'];
      if (message != null && message is String) return message;
    }
    return null;
  } catch (e) {
    return null;
  }
}

/// Maps the dio exception from data layer to the failure in domain layer
Failure mapDioExceptionToFailure(DioException e) {
  final code = e.response?.statusCode;
  final message = extractServerMessage(e.response?.data);

  /// Timout / socket exception
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return NetworkFailure(cause: e, stackTrace: e.stackTrace);
  }

  /// No internet connection
  if (e.type == DioExceptionType.connectionError) {
    return NoInternetConnectionFailure(cause: e, stackTrace: e.stackTrace);
  }

  /// Server returns error
  if (code != null) {
    if (code == 401) {
      return UnauthorizedFailure(cause: e, stackTrace: e.stackTrace);
    }

    if (code == 403) {
      return ForbiddenFailure(cause: e, stackTrace: e.stackTrace);
    }

    if (code >= 500) {
      return ServerFailure(
        cause: e,
        stackTrace: e.stackTrace,
        statusCode: code,
        message: message,
      );
    }

    /// 4xx client errors
    return ServerFailure(
      cause: e,
      stackTrace: e.stackTrace,
      statusCode: code,
      message: message,
    );
  }

  /// Unknown error
  return UnknownFailure(cause: e, stackTrace: e.stackTrace);
}
