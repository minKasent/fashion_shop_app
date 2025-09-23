/// Defines the exceptions for the data layer
/// Exception for server errors
class ServerException implements Exception {
  final int? statusCode;
  final String? message;
  final dynamic data;

  ServerException({this.statusCode, this.message, this.data});
}

class CacheException implements Exception {
  final Object? cause;

  CacheException([this.cause]);
}

class NetworkException implements Exception {
  final Object? cause;

  NetworkException([this.cause]);
}

class UnauthorizedException implements Exception {
  final Object? cause;

  UnauthorizedException([this.cause]);
}

class ForbiddenException implements Exception {
  final Object? cause;

  ForbiddenException([this.cause]);
}

class UnknownException implements Exception {
  final Object? cause;

  UnknownException([this.cause]);
}

class NoInternetConnectionException implements Exception {
  final Object? cause;

  NoInternetConnectionException([this.cause]);
}
