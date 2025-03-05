import 'package:cached_network_image/cached_network_image.dart';
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
    return CircleAvatar(
      backgroundColor: MyColors.lightBrown.withOpacity(0.2),
            radius: size.w,
            child: Container(
            
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(

                imageUrl: "$baseUrl/images/avatars/$userId",
                placeholder: (context, url) => CircleAvatar(
                  backgroundColor: MyColors.lightBrown.withOpacity(0.2),
                  foregroundColor: MyColors.brown,
                  radius: size.w,
                  child: Icon(
                    Icons.person,
                    size: size.w,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                color: MyColors.brown,
                width: 1,
                                ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: MyColors.lightBrown.withOpacity(0.2),
                    foregroundColor: MyColors.brown,
                    radius: size.w,
                    child: Icon(
                      Icons.person,
                      size: size.w,
                    ),
                  ),
                ),
              ),
            ),
          );
          
  }
}
