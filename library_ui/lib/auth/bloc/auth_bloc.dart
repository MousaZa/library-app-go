import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/auth/models/user.dart';

import '../functions/functions.dart';

sealed class AuthEvent {}

class AuthEventLogout extends AuthEvent {}

class AuthEventDelete extends AuthEvent {}

class AuthEventLogin extends AuthEvent {
  AuthEventLogin({required this.context, required this.username, required this.password});

  final String username, password;
  final BuildContext context;
}

class AuthEventRegister extends AuthEvent {
  AuthEventRegister(
      {required this.username, required this.email, required this.password});

  final String username, email, password;
}

class AuthBloc extends Bloc<AuthEvent, User> {
  AuthBloc() : super(const User.nonAuthenticated()) {

    on<AuthEventLogin>((event, emit) async {
      final response = await login(event.username, event.password);
      emit(response);
      if(response.token.isNotEmpty)
        Navigator.pushNamedAndRemoveUntil(event.context, '/home', (route) => false);
    });

    on<AuthEventRegister>((event, emit) async {
      final response = await register(event.email, event.username, event.password);
      emit(response);
    });

    on<AuthEventLogout>((event, emit) async {
      emit(logout());
    });
  }
}
