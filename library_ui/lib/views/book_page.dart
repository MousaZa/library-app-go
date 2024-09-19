import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:library_ui/controllers/borrows.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:sizer/sizer.dart';

class BookPage extends StatelessWidget {
  BookPage({super.key, required this.bookData, required this.userId});
  final Book bookData;
  final int userId;

  final borrowsController = Get.put(BorrowsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            bookData.coverURL,
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '# ${bookData.id}',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  bookData.title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookData.author,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                      bookData.category,
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
                      bookData.language,
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
                      bookData.summary,
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 3.w,
                        )),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      bookData.likes.toString(),
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
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Borrowing Book",
                            content: Column(
                              children: [
                                Text(
                                    "Are you sure you want to borrow ${bookData.title}?"),
                                Text("you will have to return it in 7 days"),
                              ],
                            ),
                            textCancel: 'Cancel',
                            textConfirm: 'Borrow',
                            onConfirm: ()async {
                              final token = await storage.read(key: 'paseto');
                              borrowsController.add(token!,bookData,userId).then((_){
                                sleep(Duration(seconds: 2));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            onCancel: (){ Navigator.pop(context);},
                          );
                        },
                        icon: Icon(
                          Icons.front_hand_outlined,
                          size: 3.w,
                        )),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      bookData.likes.toString(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
