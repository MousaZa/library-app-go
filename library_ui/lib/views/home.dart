import 'dart:math';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:choice/inline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/sidebar.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/books_page.dart';
import 'package:library_ui/views/books/books_view.dart';
import 'package:library_ui/views/notifications/notification_card.dart';
import 'package:library_ui/views/sidebar/sidebar.dart';
import 'package:library_ui/views/users/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:library_ui/views/users_list.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  factory MyHomePage.withAuth(String paseto) {
    return MyHomePage(
      paseto: paseto,
    );
  }

  final String paseto;

  final List<Widget> pages = [
    BooksPage(),
    Profile(),
    UsersList(),
  ];

  MyHomePage({super.key, required this.paseto});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.read(key: "role"),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
               floatingActionButton: snapshot1.data == "user"
                    ? null
                    : FloatingActionButton(
                        backgroundColor: MyColors.green,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddBookPage()));
                        },
                        child: Icon(Icons.add),
                      ),
                body: Row(
                  children: [
                    Sidebar(),
                    GetX<SidebarController>(
                      init: SidebarController(),
                      builder: (controller) => Expanded(
                      child: widget.pages[controller.activeItem.value],
                    ),
                    ),
                  ],
                ));
          }
        });
  }
}
