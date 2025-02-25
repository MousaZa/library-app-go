import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:library_ui/controllers/borrows.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/books/add_book_cover_page.dart';
import 'package:sizer/sizer.dart';

class AskAIPage extends StatefulWidget {
  AskAIPage({super.key, required this.bookId, required this.type});
  final int bookId;
  final String type;

  @override
  State<AskAIPage> createState() => _AskAIPageState();
}

class _AskAIPageState extends State<AskAIPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.3),
          body: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  height: 70.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FutureBuilder(
                            future: getMoreAboutBook(widget.bookId, widget.type),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  List data = snapshot.data as List;
                                  return Flexible(
                                    child: SingleChildScrollView(
                                      child: GptMarkdown('''
                                       ${data[0]}
                                          ''',
                                          style:  TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp
                                          )), 
                                    ),
                                  );
                                } else {
                                  return Center(child: Text('No data found'));
                                }
                              }
                              return loadingWidget;
                            })
                      ])),
            ),
          ),
        ));
  }
}
