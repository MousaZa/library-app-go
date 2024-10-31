import 'package:flutter/material.dart';
import 'package:library_ui/auth/view/login.dart';
import 'package:library_ui/auth/view/register.dart';
import 'package:library_ui/home/view/home.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:sizer/sizer.dart';

class LibraryApp extends MaterialApp{
  LibraryApp({super.key}) : super(
    initialRoute: '/',
    routes: {
      '/login' : (context) => LoginPage(),
      '/regiser' : (context) => RegisterPage(),
      '/add_book' : (context) => const AddBookPage(),
      '/edit_book' : (context) => EditBookPage(),
      '/' : (context) => ResponsiveSizer(builder: (context, orientation, screenType)=> Home()),
    }
    );
}