import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:intl/intl.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/views/borrows/calendar_borrow_item.dart';
import 'package:sizer/sizer.dart';
import 'package:timelines/timelines.dart';

class OngoingBorrowCard extends StatefulWidget {
  OngoingBorrowCard({super.key, required this.borrowData});

  final Borrow borrowData;

  @override
  State<OngoingBorrowCard> createState() => _OngoingBorrowCardState();
}

class _OngoingBorrowCardState extends State<OngoingBorrowCard> {
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
          future: Book.getBook(widget.borrowData.bookId),
          builder: (context, snapshot) {
            List days = [];
            final diff = widget.borrowData.endDate
                .difference(widget.borrowData.startDate)
                .inDays;
            for (int i = 0; i < diff; i++) {
              days.add(widget.borrowData.startDate.add(Duration(days: i)));
            }
            if (!snapshot.hasData) return CircularProgressIndicator();
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
                            color: MyColors.brown),
                      ),
                      Center(
                        child: SizedBox(
                          // width: 10.w,
                          height: 10.w,
                          child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            theme: TimelineThemeData(
                              nodeItemOverlap: false,
                              direction: Axis.horizontal,
                              color: MyColors.brown,                   
                              indicatorTheme: IndicatorThemeData(
                                // position: IndicatorPosition.top,
                                size: 40.0,
                                position: 0
                              ),           
                              // nodePosition: 0,
                              connectorTheme: ConnectorThemeData(
                                // indent: 3.w,
                                color: MyColors.brown, 
                                space: 100,
                                thickness: 5.0,
                              ), 
                            ),
                            builder: TimelineTileBuilder.fromStyle(
                              connectorStyle: ConnectorStyle.solidLine,
                              contentsAlign: ContentsAlign.basic,
                              // indicatorStyle: IndicatorStyle.outlined,
                              contentsBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text('$index'),
                              ),
                              itemCount: 3,
                            ),
                          ),
                        ),
                      )
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
