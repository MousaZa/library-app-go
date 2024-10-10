import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_ui/globals.dart';
import 'dart:async';

Future markAsRead(int id) async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.put(
      Uri.parse('http://localhost:8080/notifications/$id'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    return true; 
  } catch (e) {
    print(e);
  }
}

Future<List> getNotifications() async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.get(
      Uri.parse('http://localhost:8080/notifications'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to get notifications');
    }
    return jsonDecode(response.body);
  } catch (e) {
    print("error: " + e.toString());
    return [];
  }
}

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
    return true;
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
    return true;
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


