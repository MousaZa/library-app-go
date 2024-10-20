import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:intl/intl.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:sizer/sizer.dart';

class OngoingBorrowCard extends StatelessWidget {
  
  OngoingBorrowCard({super.key, required this.borrowData});

  final Borrow borrowData;
  final List<String> stages = ["pending", "taken", "returned"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      height: 20.w,
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        color: MyColors.lightGreen,
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
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Borrowed on: ${DateFormat.yMMMEd().format(borrowData.startDate)}",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            "Due on: ${DateFormat.yMMMEd().format(borrowData.endDate)}",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    SizedBox(
                      width: 30.w,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: stages.map((e) => Text(
                                  e.toUpperCase(),
                                  style: TextStyle(
                                      color: MyColors.brown,
                                      fontWeight: FontWeight.bold),
                                ), ).toList(),
                            ),
                            SizedBox(height: 20),
                            FlutterStepIndicator(
                              negativeColor: MyColors.lightBrown.withOpacity(0.1),
                              positiveColor: MyColors.brown,
                              progressColor: MyColors.brown,
                              durationCheckBulb: Duration(milliseconds: 500),
                              durationScroller: Duration(milliseconds: 800),
                              onChange: (i){
                                // print(i);
                              },
                               list: stages, 
                                page: stages.indexOf(borrowData.status),
                                height: 50,
                                ),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}
