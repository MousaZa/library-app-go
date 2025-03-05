import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:sizer/sizer.dart';

class AdminBorrowCard extends StatelessWidget {
  const AdminBorrowCard({super.key, required this.borrowData});

  final Borrow borrowData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      height: 10.w,
      width: 40.w,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FutureBuilder(
          future: Book.getBook(borrowData.bookId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loadingWidget;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!.title,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Borrowed by: ${borrowData.username}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  
                  Text(
                    "Borrowed on: ${DateFormat.yMMMEd().format(borrowData.startDate)}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    "Returned on: ${DateFormat.yMMMEd().format(borrowData.endDate)}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
