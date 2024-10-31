import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/auth/models/user.dart';

Future<User> register(String email, String username, String password) async {
  try {
    http.Response response = await http.post(
      Uri.http('localhost', '/auth/create'),
      body:
          '{ "id" : 1 , "username" : "$username" , "email" :"$email" , "password" : "$password" }',
    );
    switch (response.statusCode) {
      case 200:
        return User.fromJson(jsonDecode(response.body));
      case 409:
        throw Exception('Username already exists');
      default:
        throw Exception('An error occurred, please try again');
    }
  } catch (e) {
    Get.defaultDialog(
      title: "An Error Occurred",
      content: Text(e.toString()),
    );
    return const User.nonAuthenticated();
  }
}
