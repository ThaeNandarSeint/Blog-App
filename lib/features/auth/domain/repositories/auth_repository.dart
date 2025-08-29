import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:blog_app/core/error/app_failure.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, User>> login({
    required String email,
    required String password,
  });
}
