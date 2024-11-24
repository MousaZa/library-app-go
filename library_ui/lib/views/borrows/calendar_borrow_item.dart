import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:sizer/sizer.dart';

List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

class CalendarBorrowItem extends StatefulWidget {
  const CalendarBorrowItem({super.key, required this.date, required this.hover});
  final DateTime date;
  final bool hover;

  @override
  State<CalendarBorrowItem> createState() => _CalendarBorrowItemState();
}

class _CalendarBorrowItemState extends State<CalendarBorrowItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.hover
        ? AnimatedContainer( 
          duration: const Duration(milliseconds: 150),
          width: 5.w,
          height: 7.w,
          decoration: BoxDecoration(
          color: !widget.date.isAfter(DateTime.now()) ? MyColors.brown : MyColors.green,
          borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          Flexible(
            child: Text(
              widget.date.day.toString(),
              style: TextStyle(
                color: !widget.date.isAfter(DateTime.now()) ? MyColors.lightGreen : MyColors.brown,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Text(
              weekdays[widget.date.weekday - 1],
              style: TextStyle(
                color: !widget.date.isAfter(DateTime.now()) ? MyColors.lightGreen : MyColors.brown,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
            ],
          ),
        )
        : AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 1.w,
          height: 1.w,
          decoration: BoxDecoration(
          color: !widget.date.isAfter(DateTime.now()) ? MyColors.brown : MyColors.green,
          borderRadius: BorderRadius.circular(5),
          ),
        ),
      
    );
  }
}
