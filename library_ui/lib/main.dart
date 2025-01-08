import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/edit_book_page.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/views/users/login.dart';
import 'package:library_ui/views/users/register.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    Future<String> get pasetoOrEmpty async {
    var paseto = await storage.read(key: "paseto");
    if(paseto == null) return "";
    await getUser() == false ? paseto = "" : paseto = paseto;
    return paseto;
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(  
  builder: (context, orientation, screenType) {
    return GetMaterialApp(
        theme: ThemeData(
         scaffoldBackgroundColor: MyColors.lightBrown.withOpacity(0.1)
        ),
      // home:  LoginPage(),
    home: FutureBuilder( 
        future: pasetoOrEmpty,            
        builder: (context, snapshot) {
          if(!snapshot.hasData) return loadingWidget;
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
      GetPage(name: '/addbook', page: () => const AddBookPage()),
      GetPage(name: '/edit_book', page: () => EditBookPage()),
      GetPage(name: '/', page: () => MyHomePage(paseto: pasetoOrEmpty.toString())),
    ],
      debugShowCheckedModeBanner: false ,
      title: 'Library UI',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
    );
  },
);
  }
}



