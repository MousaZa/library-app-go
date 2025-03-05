import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:intl/intl.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/views/borrows/calendar_borrow_item.dart';
import 'package:sizer/sizer.dart';

class AdminOngoingBorrowCard extends StatefulWidget {
  AdminOngoingBorrowCard({super.key, required this.borrowData});

  final Borrow borrowData;

  @override
  State<AdminOngoingBorrowCard> createState() => _AdminOngoingBorrowCardState();
}

class _AdminOngoingBorrowCardState extends State<AdminOngoingBorrowCard> {
  final List<String> stages = ["pending", "taken", "returned"];
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
      clipBehavior: Clip.antiAlias,
      height: _hover ? 26.w : 20.w,
      width: double.infinity,
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
          future: Book.getBook(widget.borrowData.bookId),
          builder: (context, snapshot) {
            List days = [];
            final diff = widget.borrowData.endDate
                .difference(widget.borrowData.startDate)
                .inDays;
            for (int i = 0; i < diff; i++) {
              days.add(widget.borrowData.startDate.add(Duration(days: i)));
            }
            if (!snapshot.hasData) return loadingWidget;
            return Column(
              children: [
                Expanded(
                  // height: 16.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Borrowed by: ${widget.borrowData.username}",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      ],
                  ),
                ),
                MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _hover = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _hover = false;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: days.map((element) {
                      return CalendarBorrowItem(
                        date: element,
                        hover: _hover,
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
            // [

            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         snapshot.data!.title,
            //         style: TextStyle(
            //             fontSize: 20.sp, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         "Borrowed on: ${DateFormat.yMMMEd().format(borrowData.startDate)}",
            //         style: TextStyle(fontSize: 12.sp),
            //       ),
            //       Text(
            //         "Due on: ${DateFormat.yMMMEd().format(borrowData.endDate)}",
            //         style: TextStyle(fontSize: 12.sp),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(width: 5.w,),

            // ],
          }),
    );
  }
}
