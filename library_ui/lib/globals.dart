library my_prj.globals;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

const storage = FlutterSecureStorage();

class MyColors{
  // static const lightGreen = Color(0xFFE9EED9);
  static const lightBrown = Color(0xFF9A7E6F);
  // static const green = Color(0xFFCBD2A4);
  static const brown = Color(0xFF54473F);
}

Widget loadingWidget =  Center(
        child: LoadingAnimationWidget.inkDrop(
         color: MyColors.brown,
          size: 2.w,
        ));