import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:library_ui/auth/view/profile.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/home/bloc/home_bloc.dart';
import 'package:library_ui/home/view/sidebar.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/books_page.dart';
import 'package:library_ui/views/sidebar_item.dart';
import 'package:library_ui/auth/view/profile.dart';
import 'package:library_ui/views/users_list.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  final List<Widget> pages = [
    BooksPage(),
    Profile(),
    const UsersList(),
  ];
 
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: false
            ? null
            : FloatingActionButton(
                backgroundColor: MyColors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddBookPage()));
                },
                child: Icon(Icons.add),
              ),
        body: BlocProvider(
          create: (context) => HomeBloc(),
          child: BlocBuilder<HomeBloc,int>(builder: (context, state){
            return Row(
          children: [
            Sidebar(
              selectedIndex: state,
            ),
            Expanded(
              child: widget.pages[state],
            ),
          ],
        );
          }),
        )
        );
  }
}
