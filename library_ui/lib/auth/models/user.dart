import 'dart:io';
import 'package:http/http.dart' as http;

class User {
  final String token;
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;

  User(
      {required this.token,
      required this.role,
      required this.id,
      required this.name,
      required this.email,
      required this.password});

  const User.nonAuthenticated()
      : token = '',
        role = '',
        id = 0,
        name = '',
        email = '',
        password = '';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'],
      email: json['email'],
      password: json['password'] ?? '',
      role: json['role'],
      id: json['user_id'],
      token: json['access_token'],
    );
  }

  Future<bool> delete() async {
    try {
      http.Response response = await http.delete(
        Uri.http('localhost', '/auth/delete/$id'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
