import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:sizer/sizer.dart';

class TextButtonItem extends StatefulWidget {
  const TextButtonItem({super.key, required this.text,required this.onTap});
  final void Function()? onTap;
  final String text;

  @override
  State<TextButtonItem> createState() => _TextButtonItemState();
}

class _TextButtonItemState extends State<TextButtonItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isHovered ? MyColors.brown.withOpacity(.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ), 
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
    );
  }
}
