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

import 'dart:async';


class TypewriterText extends StatefulWidget {
  final String text;
  final Duration duration;

  const TypewriterText(
      {Key? key,
      required this.text,
      this.duration = const Duration(milliseconds: 100)})
      : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_displayText.length < widget.text.length) {
        setState(() {
          _displayText += widget.text[_displayText.length];
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GptMarkdown(_displayText,
        style: TextStyle(color: Colors.black, fontSize: 13.sp));
  }
}

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
                  // height: 70.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(top: 40, bottom: 20, right: 40, left: 40),
                  margin: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder(
                            future:
                                getMoreAboutBook(widget.bookId, widget.type),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  List data = snapshot.data as List;
                                  return Flexible(
                                    child: SingleChildScrollView(
                                        child: TypewriterText(
                                      text: data[0],
                                      duration: Duration(milliseconds: 5),
                                    )),
                                  );
                                } else {
                                  return Center(child: Text('No data found'));
                                }
                              }
                              return loadingWidget;
                            }),
                        SizedBox(height: 20),
                            Container(
                              width: 10.w,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.lightBrown.withOpacity(.4)
                              ),
                            ),
                      ])),
            ),
          ),
        ));
  }
}
