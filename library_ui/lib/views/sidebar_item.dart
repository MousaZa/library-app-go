import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:sizer/sizer.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({
    Key? key,
    required this.icon,
    required this.title,

    required this.ext,
    this.isActive = false,
  }) : super(key: key);

  final IconData icon;
  final bool ext;

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Flexible(
          child: isActive ? Container(
            width: ext ? 5.5.w :1.7.w,
            height: 1.w,
            decoration: BoxDecoration(
              color: MyColors.green.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
          ) : Container(),
        ),
        ext ? Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Icon(icon, size: 1.5.w,color: isActive ? Colors.black: MyColors.lightBrown,),
                                  SizedBox(
                                    width: 4.w,
                                    child: Center(
                                      child: Text(title,style: TextStyle(
                                    color: isActive ? Colors.black: MyColors.lightBrown,
                                    fontWeight: FontWeight.bold,
                                     fontSize: 10.sp
                                  ),
                                  overflow: TextOverflow.ellipsis,),
                                    ),
                                  ),
                                ],) : Flexible(child: Center(child: Icon(icon, size: 1.5.w,color: isActive ? Colors.black: MyColors.lightBrown,))),
      ],
    );
                          ;
  }
}