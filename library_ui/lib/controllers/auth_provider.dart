// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:library_ui/models/user.dart';
// import 'package:library_ui/functions.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthState extends GetxController {

//  User _user = const User.empty();
//  User get userInfo => _user;
//  void setUser(User user) {
//     _user = user;
//     update();
//   }

//  void logout(){
//    _user = const User.empty(); 
//    update();
//  }

// bool get isAuthorized {
//  return _user.token.isNotEmpty;
// }

// bool displayedOnboard = false;

// Future<void> refreshToken() async {
//   final preferences = await SharedPreferences.getInstance();
//   final user = await login(preferences.getString('email') ?? '', preferences.getString('password') ?? '');
//   if (user != null) {
//     _user = user;
//     update();
//   }
// }

// Future<bool> tryLogin() async {
//   debugPrint('trying to login with username: ${_user.email} and password: ${_user.password}');
//   final preferences = await SharedPreferences.getInstance();
  
//   // fetch user info
//   final user = await login(preferences.getString('email') ?? '', preferences.getString('password') ?? '');
//   if (user != null) {
//     _user = user; 
//     return true;
//   }
//   return false;
// }
// }