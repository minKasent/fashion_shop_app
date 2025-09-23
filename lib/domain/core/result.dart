
import 'package:dartz/dartz.dart';

import 'failures.dart';

/// Defines the type of the result of the usecase
/// Either is a type that represents a value of one or two possible types
/// (a success or a failure)
/// [T] is the type of the success value
/// [Failure] is the type of the failure value
/// [ResultEither] is a type that represents a value of one or two possible types
/// [typedef] is keyword in Dart that is used to define a new type
typedef ResultEither<T> = Either<Failure, T>;

/// Defines the type of the result of the usecase async
typedef ResultFuture<T> = Future<ResultEither<T>>;
