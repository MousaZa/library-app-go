import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/borrows.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/books/add_book_cover_page.dart';
import 'package:sizer/sizer.dart';

class BookPage extends StatefulWidget {
  BookPage({super.key, required this.bookData, required this.userId});
  final Book bookData;
  final int userId;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final borrowsController = Get.put(BorrowsController());
  bool _coverHover = false;

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
              height: 65.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: storage.read(key: "role"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data == "admin") {
                          return StatefulBuilder(builder: (context, setstate) {
                            return Container(
                              height: 60.h,
                              width: 40.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "$baseUrl/images/covers/${widget.bookData.id}",
                                    height: 60.h,
                                    width: 40.h,
                                    fit: BoxFit.cover,
                                  ),
                                  MouseRegion(
                                    onEnter: (event) {
                                      setstate(() {
                                        _coverHover = true;
                                      });
                                    },
                                    onExit: (event) {
                                      setstate(() {
                                        _coverHover = false;
                                      });
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 40.h,
                                      child: MaterialButton(
                                        hoverColor:
                                            Colors.black.withOpacity(0.5),
                                        child: Center(
                                          child: _coverHover
                                              ? Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.white,
                                                  size: 3.w,
                                                )
                                              : null,
                                        ),
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddBookCoverPage(
                                                          id: widget
                                                              .bookData.id)));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        }
                        return Container(
                          height: 60.h,
                          width: 40.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            "$baseUrl/images/covers/${widget.bookData.id}",
                            height: 60.h,
                            width: 40.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '# ${widget.bookData.id}',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            widget.bookData.title,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.bookData.author,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.book_outlined,
                                size: 30,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                widget.bookData.category,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Icon(
                                Icons.language,
                                size: 30,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                widget.bookData.language,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                              width: 40.w,
                              child: Text(
                                widget.bookData.summary,
                                maxLines: 20,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            FutureBuilder(
                                future: getLike(widget.bookData.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                      size: 3.w,
                                    );
                                  }
                                  return IconButton(
                                      onPressed: () async {
                                        if (snapshot.data == true) {
                                          final delete = await deleteLike(
                                              widget.bookData.id);
                                          if (delete) {
                                            widget.bookData.likes -= 1;
                                          }
                                        } else {
                                          final add = await likeBook(
                                              widget.bookData.id);
                                          if (add) {
                                            widget.bookData.likes += 1;
                                          }
                                        }
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        snapshot.data!
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: snapshot.data!
                                            ? Colors.red
                                            : Colors.black,
                                        size: 3.w,
                                      ));
                                }),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              widget.bookData.likes.toString(),
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            IconButton(
                                disabledColor: Colors.grey,
                                color: Colors.black,
                                onPressed: widget.bookData.available
                                    ? () {
                                        Get.defaultDialog(
                                          title: "Borrowing Book",
                                          content: Column(
                                            children: [
                                              Text(
                                                  "Are you sure you want to borrow ${widget.bookData.title}?"),
                                              Text(
                                                  "you will have to return it in 7 days"),
                                            ],
                                          ),
                                          textCancel: 'Cancel',
                                          textConfirm: 'Borrow',
                                          onConfirm: () async {
                                            final token = await storage.read(
                                                key: 'paseto');
                                            borrowsController
                                                .add(token!, widget.bookData,
                                                    widget.userId)
                                                .then((_) {
                                              sleep(Duration(seconds: 2));
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            });
                                          },
                                          onCancel: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.front_hand_outlined,
                                  size: 3.w,
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              widget.bookData.borrows.toString(),
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
