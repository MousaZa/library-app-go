import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

class User {

  final String token;

  final int id;
  final String name;
  final String email;
  final String password;

  User({required this.token,required this.id,required this.name,required this.email,required this.password});

  const User.empty() : token = '', id = 0, name = '', email = '', password = '';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user']['username'],
      email: json['user']['email'],
      password: json['user']['password'],
      id: json['user']['id'],
      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };

  Future delete() async {
  try{
    http.Response response = await http.delete(
    Uri.parse('http://localhost/auth/delete/$id'),
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  return response.statusCode;
  }catch(e){
    print(e);
  }
}
}