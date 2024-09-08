import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/views/login.dart';
import 'package:library_ui/views/register.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/add_book': (context) => AddBookPage(),
        '/edit_book': (context) => EditBookPage(),
      },
      debugShowCheckedModeBanner: false ,
      title: 'Library UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



