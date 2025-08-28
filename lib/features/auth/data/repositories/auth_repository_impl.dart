import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, String>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, String>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    }
  }
}
