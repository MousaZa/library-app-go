import 'package:bloc/bloc.dart';
import 'package:library_ui/models/user.dart';

import '../functions/functions.dart';

sealed class AuthEvent{}

class AuthEventLogin extends AuthEvent{

  AuthEventLogin({required this.username, required this.password});

  final String username, password;
}

class AuthEventRegister extends AuthEvent{

  AuthEventRegister({required this.username, required this.email, required this.password});

  final String username, email, password;
}

class AuthBloc extends Bloc<AuthEvent, User>{
  AuthBloc() : super(const User.nonAuthenticated()){
     on<AuthEventLogin>((event, emit) async{
        try {
          final response = await login(event.username, event.password);
          emit(response);
        } catch (e) {
          emit(const User.nonAuthenticated());
        }
    });
  }
}