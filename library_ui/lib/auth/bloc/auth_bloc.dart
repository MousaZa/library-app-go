import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/auth/models/user.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';

import '../functions/functions.dart';

sealed class AuthState {}

class AuthStateAuthenticated extends AuthState {
  AuthStateAuthenticated({required this.user});

  final User user;
}

class AuthStateUnauthenticated extends AuthState {}

sealed class AuthEvent {}

class AuthEventLogout extends AuthEvent {}

class AuthEventDelete extends AuthEvent {}

class AuthEventLogin extends AuthEvent {
  AuthEventLogin({required this.context, required this.username, required this.password});

  final String username, password;
  final BuildContext context;
}
class AuthEventCheckAuthentication extends AuthEvent {}

class AuthEventRegister extends AuthEvent {
  AuthEventRegister(
      {required this.username, required this.email, required this.password});

  final String username, email, password;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUnauthenticated()) {

    on<AuthEventCheckAuthentication>((event, emit)async {
      // Check authentication status 
      String? token = await storage.read(key: 'token');
      bool isAuthenticated = token != null ;
 
      if (isAuthenticated) {
        final user = await getUser(token);
        emit(AuthStateAuthenticated(user: user));
      } else {
        emit(AuthStateUnauthenticated());
      }
    });
    
    on<AuthEventLogin>((event, emit) async {
      final response = await login(event.username, event.password);
      emit(AuthStateAuthenticated(user: response));
      if(response.token.isNotEmpty){
        Navigator.pushNamedAndRemoveUntil(event.context, '/', (route) => false);
      }
    });

    on<AuthEventRegister>((event, emit) async {
      final response = await register(event.email, event.username, event.password);
      emit(AuthStateAuthenticated(user: response));
    });

    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateUnauthenticated());
    });
  }
}
