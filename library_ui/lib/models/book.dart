import 'dart:convert';

import 'package:http/http.dart' as http;

class Book {

  static const String url = 'http://localhost:9090/books';

  int id;
  String title;
  String author;
  String coverURL;
  String category;
  String language;
  String summary;
  int likes;
  int borrows;

  Book(
      {required this.id,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
      Uri.parse('$url/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  return jsonDecode(response.body);
  }

  Future add() async {
  print("""""""dsadsadasdasdsadsadasdsa""""""");
  try{
    
    http.Response response = await http.post(
    Uri.parse(url),
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
