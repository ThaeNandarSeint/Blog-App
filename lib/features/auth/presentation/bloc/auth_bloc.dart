import 'package:blog_app/features/auth/domain/usecases/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register _register;

  AuthBloc({required Register register})
    : _register = register,
      super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      final res = await _register(
        RegisterParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (error) => emit(AuthFailure(message: error.message)),
        (result) => emit(AuthSuccess(uid: result)),
      );
    });
  }
}
