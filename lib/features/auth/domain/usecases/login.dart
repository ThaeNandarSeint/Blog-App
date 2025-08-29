import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/interfaces/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Login implements Usecase<User, LoginParams> {
  final AuthRepository authRepository;
  const Login(this.authRepository);

  @override
  Future<Either<AppFailure, User>> call(LoginParams params) {
    return authRepository.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
