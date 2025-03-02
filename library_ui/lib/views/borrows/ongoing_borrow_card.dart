import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:intl/intl.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/views/borrows/calendar_borrow_item.dart';
import 'package:library_ui/views/borrows/widgets/borrow_stage.dart';
import 'package:sizer/sizer.dart';
// import 'package:timelines/timelines.dart';

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
                      Center(
                        child: SizedBox(
                          // width: 10.w,
                          height: 5.w,
                          child: LoanStatusStepper(status: widget.borrowData.status),
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


class LoanStatusStepper extends StatelessWidget {
  final String status; // "pending", "taken", "returned"
  
  const LoanStatusStepper({required this.status});
  
  @override
  Widget build(BuildContext context) {
    final currentStep = _getStepFromStatus(status);
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStep(1, "Pending", currentStep >= 1),
              _buildConnector(currentStep >= 2),
              _buildStep(2, "Taken", currentStep >= 2),
              _buildConnector(currentStep >= 3),
              _buildStep(3, "Returned", currentStep >= 3),
            ],
          ),
        ],
      ),
    );
  }
  
  int _getStepFromStatus(String status) {
    switch (status.toLowerCase()) {
      case "pending": return 1;
      case "taken": return 2;
      case "returned": return 3;
      default: return 0;
    }
  }
  
  Widget _buildStep(int stepNumber, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 2.w,
            height: 2.w,
            decoration: BoxDecoration(
              color: isActive ? MyColors.brown : MyColors.lightBrown.withOpacity(.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isActive
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    "$stepNumber",
                    style: TextStyle(color: MyColors.brown,),
                  ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? MyColors.brown : MyColors.lightBrown.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConnector(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Colors.blue : Colors.grey.shade300,
    );
  }
}
