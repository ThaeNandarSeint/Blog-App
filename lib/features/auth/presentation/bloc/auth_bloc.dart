import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/login.dart';
import 'package:blog_app/features/auth/domain/usecases/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register _register;
  final Login _login;

  AuthBloc({required Register register, required Login login})
    : _register = register,
      _login = login,
      super(AuthInitial()) {
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _register(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (error) => emit(AuthFailure(message: error.message)),
      (result) => emit(AuthSuccess(user: result)),
    );
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (error) => emit(AuthFailure(message: error.message)),
      (result) => emit(AuthSuccess(user: result)),
    );
  }
}
