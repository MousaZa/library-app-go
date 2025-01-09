import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:sizer/sizer.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.userId, required this.size});
  final String userId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchImage("$baseUrl/images/avatars/$userId"),
      builder: (context, AsyncSnapshot<ImageProvider> imageSnapshot) {
        if (imageSnapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        } else if (!imageSnapshot.hasError && imageSnapshot.hasData) {
          return CircleAvatar(
              backgroundColor: MyColors.lightBrown.withOpacity(0.2),
              foregroundColor: MyColors.brown,
              radius: size.w,
              backgroundImage: imageSnapshot.data);
        }
        return CircleAvatar(
          backgroundColor: MyColors.lightBrown.withOpacity(0.2),
          foregroundColor: MyColors.brown,
          radius: size.w,
          child: Icon(
            Icons.person,
            size: size.w,
          ),
        );
      },
    );
  }
}
