  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:http/http.dart' as http;
import 'package:library_ui/models/user.dart';
  
  Future<User> login(String username, String password) async {
    try {
      http.Response response = await http.post(
        Uri.http('localhost', '/auth/login'),
        body: '{ "username": "$username", "password": "$password" }',
      );
      switch (response.statusCode) {
        case 200:
          return User.fromJson(jsonDecode(response.body));
        case 403:
          throw Exception('Wrong password');              
        case 404:
          throw Exception('No account was found matching that username'); 
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