import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/views/login.dart';
import 'package:library_ui/views/register.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    Future<String> get pasetoOrEmpty async {
    var paseto = await storage.read(key: "paseto");
    if(paseto == null) return "";
    await getUser(paseto) == false ? paseto = "" : paseto = paseto;
    return paseto;
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(  
  builder: (context, orientation, screenType) {
    return MaterialApp(
      home: GetMaterialApp(
      // home:  LoginPage(),
    home: FutureBuilder( 
        future: pasetoOrEmpty,            
        builder: (context, snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data != "") {
            var str = snapshot.data;
                return MyHomePage.withAuth(str!);
          } else {
            return LoginPage();
          }
        }
      ),
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/register', page: () => RegisterPage()),
      GetPage(name: '/addbook', page: () => AddBookPage()),
      GetPage(name: '/editbook', page: () => EditBookPage()),
      GetPage(name: '/', page: () => MyHomePage(paseto: pasetoOrEmpty.toString())),
    ],
      debugShowCheckedModeBanner: false ,
      title: 'Library UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    )
    );
  },
);
  }
}



