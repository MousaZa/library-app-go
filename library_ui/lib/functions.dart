import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_ui/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<String> login(String username, String password) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  try{
    
    http.Response response = await http.post(
    Uri.parse('http://localhost:8080/login'),
    // headers: '"Content-Type": "application/json"'
    body: '{ "username": "$username", "password": "$password" }',
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to login');
  }
  print(jsonDecode(response.body));
  return jsonDecode(response.body)['access_token'];

  }catch(e){
    print(e);
    return 'error';
  }
}

Future register(String email, String username, String password) async {
  
  try{
    
    http.Response response = await http.post(
    Uri.http('localhost:8080','/create'),
    // headers: '"Content-Type": "application/json"' 
    body: '{ "id" : 1 , "username" : "$username" , "email" :"$email" , "password" : "$password" }',
  );
  if (response.statusCode != 200) {
    print(response.body);
    throw Exception('Failed to create user');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
}

Future delete(int id,String token) async {
  
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

Future getBooks(String search,language,category) async {
  
  try{
    
    http.Response response = await http.get(
    Uri.http('localhost:9090', '/books', {'search': search, 'language': language, 'category': category}),
  
    // headers: '"Content-Type": "application/json"'
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to get books');
  }
  // print (jsonDecode(response.body));
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
}

