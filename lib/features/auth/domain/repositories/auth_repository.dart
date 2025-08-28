import 'package:fpdart/fpdart.dart';
import 'package:blog_app/core/error/app_failure.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, String>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, String>> login({
    required String email,
    required String password,
  });
}
