import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/interfaces/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements Usecase<User, GetCurrentUserParams> {
  final AuthRepository authRepository;
  GetCurrentUser(this.authRepository);

  @override
  Future<Either<AppFailure, User>> call(GetCurrentUserParams params) async {
    return await authRepository.getCurrentUser();
  }
}

class GetCurrentUserParams {}
