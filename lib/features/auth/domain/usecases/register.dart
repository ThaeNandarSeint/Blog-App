import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/interfaces/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Register implements Usecase<User, RegisterParams> {
  final AuthRepository authRepository;
  const Register(this.authRepository);

  @override
  Future<Either<AppFailure, User>> call(RegisterParams params) async {
    return await authRepository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
