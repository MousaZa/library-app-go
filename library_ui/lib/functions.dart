import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/user.dart';
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

Future likeBook(int bookId) async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.post(
      Uri.parse('http://localhost:8080/like/$bookId'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like book');
    }
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}


Future deleteLike(int bookId) async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.delete(
      Uri.parse('http://localhost:8080/like/$bookId'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like book');
    }
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}


Future<bool> getLike(int bookId) async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.get(
      Uri.parse('http://localhost:8080/like/$bookId'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like book');
    }
    return jsonDecode(response.body)['response'];
  } catch (e) {
    print(e);
    return false;
  }
}

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

Future getUser(String token) async {
  try{
    
    http.Response response = await http.get(
    Uri.parse('http://localhost:8080/user'),
    // headers: '"Content-Type": "application/json"' 
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  if (response.statusCode  == 401) {
    print(jsonDecode(response.body));
    return false;
  }if (response.statusCode != 200) {
    throw Exception('Failed to get user');
  }
  print(jsonDecode(response.body));
  return jsonDecode(response.body);
  }catch(e){
    print(e);
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

Future createBorrow(int bookId,userId) async {
  try{
    final token = await storage.read(key: "paseto");
    http.Response response = await http.post(
    Uri.parse('http://localhost:8080/borrow'),
    // headers: '"Content-Type": "application/json"'
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    body: '{ "bookId": $bookId, "userId": $userId }',
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to borrow book');
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
  return response.statusCode;
  }catch(e){
    print(e);
  }
}
Stream<dynamic> getBooks(String search, String language, String category) async* {
  try {
    // Create a WebSocket channel
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:9090/books?search=$search&language=$language&category=$category'),
    );

    // Stream the data from the WebSocket
    await for (var message in channel.stream) {
      yield jsonDecode(message);
    }
  } catch (e) {
    print('Error occurred: $e');
    yield [];
  }
}

