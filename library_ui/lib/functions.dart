import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/globals.dart';
import 'dart:async';

Future markAsRead(int id) async {
  try {
    final token = await storage.read(key: "paseto");
    http.Response response = await http.put(
      Uri.parse('$baseUrl/auth/notifications/$id'),
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
      Uri.parse('$baseUrl/auth/notifications'),
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
      Uri.parse('$baseUrl/auth/like/$bookId'),
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
      Uri.parse('$baseUrl/auth/like/$bookId'),
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
      Uri.parse('$baseUrl/auth/like/$bookId'),
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

Future  getUser() async {
  try{
    final token = await storage.read(key: "paseto");
    
    http.Response response = await http.get(
    Uri.parse('$baseUrl/auth/user'),
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

Future<ImageProvider> fetchImage(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return NetworkImage(url);
    } else {
      throw Exception('Failed to load image');
    }
  } catch (e) {
    throw Exception('Failed to load image');
  }
}

Future createBorrow(int bookId,userId) async {
  try{
    final token = await storage.read(key: "paseto");
    http.Response response = await http.post(
    Uri.parse('$baseUrl/auth/borrow'),
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

Future<http.StreamedResponse> uploadAvatar(Uint8List? fileBytes, String fileName, int id) async {
    
    final uri = Uri.parse('$baseUrl/images/avatars/$id');
    final request = http.MultipartRequest('POST', uri);
    final multipartFile = http.MultipartFile.fromBytes('upload', fileBytes!,filename: fileName);
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['File-Name'] = fileName;

    request.files.add(multipartFile);
    final response = await request.send();

    return response;
  }
  


