import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:sizer/sizer.dart';

class OngoingBorrowCard extends StatelessWidget {
  const OngoingBorrowCard({super.key, required this.borrowData});

  final Borrow borrowData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      height: 20.w,
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
          future: getBook(borrowData.bookId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            snapshot.data["title"],
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Borrowed on: ${borrowData.startDate}",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            "Due on: ${borrowData.endDate}",
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
                              children: [
                                Text(
                                  "Pending",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                ), 
                                Text(
                                  "Taken",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                ), 
                                Text(
                                  "Returned",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                ), 
                              ], 
                            ),
                            SizedBox(height: 20),
                            FlutterStepIndicator(
                              negativeColor: Colors.purple.withOpacity(0.1),
                              positiveColor: Colors.purple,
                              progressColor: Colors.purple,
                              durationCheckBulb: Duration(milliseconds: 500),
                              durationScroller: Duration(milliseconds: 800),
                              onChange: (i){
                                // print(i);
                              },
                               list: ["pending", "taken", "returned"], 
                                page: 1,
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