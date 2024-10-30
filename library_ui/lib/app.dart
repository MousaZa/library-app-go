import 'package:flutter/material.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/views/users/login.dart';
import 'package:library_ui/views/users/register.dart';
import 'package:sizer/sizer.dart';

class LibraryApp extends MaterialApp{
  LibraryApp({super.key}) : super(
    initialRoute: '/',
    routes: {
      '/login' : (context) => LoginPage(),
      '/regiser' : (context) => RegisterPage(),
      '/add_book' : (context) => const AddBookPage(),
      '/edit_book' : (context) => EditBookPage(),
      '/' : (context) => ResponsiveSizer(builder: (context, orientation, screenType)=> HomePage(paseto: '',)),
    }
    );
}