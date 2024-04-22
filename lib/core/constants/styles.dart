 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';


TextStyle extraLargeTextStyle = TextStyle(
    color: Colors.black, fontSize: 23.sp, fontWeight: FontWeight.w600);
TextStyle largeTextStyle = TextStyle(
    color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w600);
TextStyle standardTextStyle = TextStyle(
    color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600);
TextStyle regularTextStyleWhite = TextStyle(
    color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600);
TextStyle regularTextStyle = TextStyle(
    color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w600);
TextStyle smallTextStyle = TextStyle(
    color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w400);

BoxDecoration sectionContainerDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
          color: greyColor,
          blurStyle: BlurStyle.outer,
          spreadRadius: 2,
          blurRadius: 2)
    ],
    borderRadius: BorderRadius.circular(15).r);