import 'package:blog_app/core/error/app_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<AppFailure, SuccessType>> call(Params params);
}
