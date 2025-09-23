import 'package:fashion_shop/domain/core/result.dart';

/// Base Usecase for all usecases

/// Use case interface for synchronous use cases
abstract class UseCase<Result, Params> {
  ResultEither<Result> call(Params params);
}

/// Use case interface for asynchronous use cases
/// Example when implement with IO (DB / API)
abstract class UseCaseAsync<Result, Params> {
  ResultFuture<Result> call(Params params);
}

/// No params for use cases
class NoParams {}

///
// int sum(int a, int b) => a + b;
