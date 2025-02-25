import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextButtonItem extends StatelessWidget {
  const TextButtonItem({super.key, required this.text,required this.onTap});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 12.sp),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        // padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(10),

        )),
        surfaceTintColor:  MaterialStateProperty.all(Colors.white),
      ),
      onPressed: onTap,
    );
  }
}
