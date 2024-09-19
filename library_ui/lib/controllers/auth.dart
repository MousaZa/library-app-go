import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Auth extends GetxController{
  
  Future<String> login(String username, String password) async {
  try{
    http.Response response = await http.post(

    Uri.parse('http://localhost:8080/login'),

    body: '{ "username": "$username", "password": "$password" }',

  );
  print(response.statusCode);
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body)['access_token'];
      break;
    case 403:
      Get.defaultDialog(title:  "An Error Occurred",content: Text( "Wrong password"));
      return 'error';
      break;
    case 404:
      Get.defaultDialog(title:  "An Error Occurred",content: Text( "No account was found matching that username"));
      return 'error';
      break;
    default:
      return 'error';
  }
  }catch(e){
    Get.defaultDialog(title:  "An Error Occurred",content: Text( "An error occurred, please try again"));
    print(e);
    return 'error';
  }
}

Future<String> register(String email, String username, String password) async {
  
  try{
    
    http.Response response = await http.post(

    Uri.http('localhost:8080','/create'),

    body: '{ "id" : 1 , "username" : "$username" , "email" :"$email" , "password" : "$password" }',

  );
  switch (response.statusCode) {
    case 200:
      return 'ok';
      break;
    case 409:
      Get.defaultDialog(title:  "An Error Occurred",content: Text( "Username already exists"));
      return 'error';
      break;
    default:
      return 'error';
  }
  }catch(e){
    Get.defaultDialog(title:  "An Error Occurred",content: Text( "An error occurred, please try again"));
    print(e);
    return 'error';
  }
}


}