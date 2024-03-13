import 'package:fpdart/fpdart.dart';
import 'package:x_clone_flutter/core/failure/failure.dart';

abstract interface class UseCase<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
