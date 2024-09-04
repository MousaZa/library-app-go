import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future login(String username, String password) async {
  
  try{
    
    http.Response response = await http.post(
    Uri.parse('http://localhost:8080/login'),
    // headers: '"Content-Type": "application/json"'
    body: '{ "username": "$username", "password": "$password" }',
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to login');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
}

Future register(String email, String username, String password) async {
  
  try{
    
    http.Response response = await http.post(
    Uri.parse('http://localhost:8080/create'),
    // headers: '"Content-Type": "application/json"'
    body: '{ "id" : "1" , "username" : "$username" , "email" :"$email" , "password" : "$password" }',
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to create user');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
}

Future delete(String id,token) async {
  
  try{
    
    http.Response response = await http.delete(
    Uri.parse('http://localhost:8080/delete/$id'),
    // headers: '"Content-Type": "application/json"'
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to login');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
}