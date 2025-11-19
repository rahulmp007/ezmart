import 'package:ezmart/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<AppError, T>> call(Params params);
}

class NoParams {}
