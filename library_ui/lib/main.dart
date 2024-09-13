import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/views/login.dart';
import 'package:library_ui/views/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    home: FutureBuilder(
        future: jwtOrEmpty,            
        builder: (context, snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data != "") {
            var str = snapshot.data;
            var jwt = str?.split(".");

            if(jwt?.length !=3) {
              return LoginPage();
            } else {
              var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt![1]))));
              if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                return MyHomePage(jwt: str!,payload: payload,);
              } else {
                return LoginPage();
              }
            }
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
    ],
      debugShowCheckedModeBanner: false ,
      title: 'Library UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



