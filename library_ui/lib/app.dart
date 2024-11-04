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

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/register': (context) => RegisterPage(),
              '/add_book': (context) => const AddBookPage(),
              '/edit_book': (context) => EditBookPage(),
              '/': (context) => context.read<AuthBloc>().state == AuthStateUnauthenticated()
                  ? LoginPage()
                  : Home(),
            },
          ),
        );
      },
    );
  }
}
