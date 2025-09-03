import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<AppFailure, User>> login({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async =>
          await remoteDataSource.login(email: email, password: password),
    );
  }

  @override
  Future<Either<AppFailure, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<AppFailure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(AppFailure(message: 'No Internet Connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(AppFailure(message: e.message));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, User>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(AppFailure(message: 'User not logged in!'));
        }
        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(AppFailure(message: 'User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    }
  }
}
