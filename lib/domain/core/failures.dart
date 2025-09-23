/// Base class for all failures with a cause and stack trace
/// This is used to handle the failures in the domain layer
abstract class Failure {
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure({this.cause, this.stackTrace});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.cause, super.stackTrace});
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? message;

  const ServerFailure({
    this.statusCode,
    this.message,
    super.cause,
    super.stackTrace,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({super.cause, super.stackTrace});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.cause, super.stackTrace});
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.cause, super.stackTrace});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.cause, super.stackTrace});
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure({super.cause, super.stackTrace});
}
