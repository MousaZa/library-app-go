import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:library_ui/globals.dart';
import 'package:mime/mime.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Book {


  int id;
  String title;
  String author;
  String coverURL;
  String category;
  String language;
  String summary;
  int likes;
  int borrows;
  bool available;

  Book(
      {required this.id,
      required this.available,
      required this.title,
      required this.author,
      required this.coverURL,
      required this.category,
      required this.language,
      required this.summary,
      required this.likes,
      required this.borrows});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      available: json['available'],
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverURL: json['coverURL'],
      category: json['category'],
      language: json['language'],
      summary: json['summary'],
      likes: json['likes'],
      borrows: json['borrows'],
    );
  }

  factory Book.empty(){
    return Book(id: 0, available: false, title: '', author: '', coverURL: '', category: '', language: '', summary: 
  '', likes: 0, borrows: 0);
  }

  static Future<Book> getBook(int id) async {
  try{
    http.Response response = await http.get(
    Uri.parse('$baseUrl/books/$id'),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to get book');
  }
  return Book.fromJson(jsonDecode(response.body));
  }catch(e){
    
    print(e);
    return Book.empty();
  }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['available'] = available;
    data['title'] = title;
    data['author'] = author;
    data['coverUrl'] = coverURL;
    data['category'] = category;
    data['language'] = language;
    data['summary'] = summary;
    data['likes'] = likes;
    data['borrows'] = borrows;

    return data;
  }

  Future delete() async {
    http.Response response = await http.delete(
      Uri.parse('$baseUrl/books/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  return jsonDecode(response.body);
  }

  static Future<dynamic> uploadCover(Uint8List? fileBytes, String fileName, int id) async {
    
    final uri = Uri.parse('$baseUrl/images/covers/$id');
    final request = http.MultipartRequest('POST', uri);
    final multipartFile = await http.MultipartFile.fromBytes('upload', fileBytes!,filename: fileName);
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['File-Name'] = fileName;

    request.files.add(multipartFile);
    final response = await request.send();

    return response;
  }


  Future add() async {
  try{
    http.Response response = await http.post(
    Uri.parse("$baseUrl/books"),
    body: jsonEncode(toJson()),
  );
  if (response.statusCode != 201) { 
    throw Exception('Failed to add book');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
} 

  Future update() async {
  try{
    
    http.Response response = await http.put(
    Uri.parse("$baseUrl/books/$id"),
    body: jsonEncode(toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add book');
  }
  return jsonDecode(response.body);
  }catch(e){
    print(e);
  }
} 

}
