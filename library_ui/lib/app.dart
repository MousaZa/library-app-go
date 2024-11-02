import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/auth/auth.dart';
import 'package:library_ui/auth/view/login.dart';
import 'package:library_ui/auth/view/register.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/home/view/home.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/edit_book_page.dart';
import 'package:sizer/sizer.dart';

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  Future<String> get pasetoOrEmpty async {
    var paseto = await storage.read(key: "paseto");
    if (paseto == null) return "";
    await getUser() == false ? paseto = "" : paseto = paseto;
    return paseto;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext , Orientation , ScreenType ) { 
        return BlocProvider<AuthBloc>(
          create: (context) { 
            return AuthBloc();
           },
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/login': (context) => LoginPage(),
            '/regiser': (context) => RegisterPage(),
            '/add_book': (context) => const AddBookPage(),
            '/edit_book': (context) => EditBookPage(),
            '/home': (context) => ResponsiveSizer(
                builder: (context, orientation, screenType) => Home()),
            '/': (context) => FutureBuilder(
                  future: pasetoOrEmpty,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.data != "") {
                      var str = snapshot.data;
                      return Home();
                    } else {
                      return LoginPage();
                    }
                  },
                ),
          },
                ),
        );
       },
      
    );
  }
}