import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/login.dart';
import 'package:blog_app/features/auth/domain/usecases/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register _register;
  final Login _login;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required Register register,
    required Login login,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUserCubit,
  }) : _register = register,
       _login = login,
       _getCurrentUser = getCurrentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
    on<AuthGetCurrentUser>(_onGetCurrentUser);
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    final res = await _register(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (error) => emit(AuthFailure(message: error.message)),
      (result) => _emitAuthSuccess(result, emit),
    );
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (error) => emit(AuthFailure(message: error.message)),
      (result) => _emitAuthSuccess(result, emit),
    );
  }

  void _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getCurrentUser(GetCurrentUserParams());
    res.fold(
      (error) => emit(AuthFailure(message: error.message)),
      (result) => _emitAuthSuccess(result, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
