
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/core/failures.dart';
import '../../domain/core/result.dart';
import 'dio_failure_mapper.dart';
import 'exceptions.dart';

/// Guard for dio exceptions and other exceptions which ar not handled by the dio
/// This guard is used to handle the exceptions and return the failure or T -> Result of task
/// task is the function that is called to get the data
/// stackTrace is the stack trace of the exception
/// <T> generic type of the task
ResultFuture<T> guardDio<T>(Future<T> Function() task) async {
  try {
    final data = await task();
    return Right(data);
  } on DioException catch (e) {
    return Left(mapDioExceptionToFailure(e));
  } on UnauthorizedException catch (e, stackTrace) {
    return Left(UnauthorizedFailure(cause: e, stackTrace: stackTrace));
  } on ForbiddenException catch (e, stackTrace) {
    return Left(ForbiddenFailure(cause: e, stackTrace: stackTrace));
  } on CacheException catch (e, stackTrace) {
    return Left(CacheFailure(cause: e, stackTrace: stackTrace));
  } on NetworkException catch (e, stackTrace) {
    return Left(NetworkFailure(cause: e, stackTrace: stackTrace));
  } on NoInternetConnectionException catch (e, stackTrace) {
    return Left(NoInternetConnectionFailure(cause: e, stackTrace: stackTrace));
  } on UnknownException catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  } catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  }
}
