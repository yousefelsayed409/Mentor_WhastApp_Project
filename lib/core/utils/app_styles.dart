import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

abstract class AppStyles {
  static final pacifico400style60 = TextStyle(
    fontSize: 60.sp,
    color: AppColors.black,
   
  );
  static final poppins400style12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.deepGrey,
    fontFamily: "Poppins",
  );
  static final poppins500style14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: "Poppins",
  );
  static final textStyle23 = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static final textStyl16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final textStyle15 = TextStyle(
    fontSize: 15.sp,
    // fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final textStyle13 = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.lightColor,
  );
  static final textStyle15grey = TextStyle(
    fontSize: 15.sp,
    height: 1,
    fontWeight: FontWeight.w600,
    color: Color(0xff93989B),
  );

  static final textStyle18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final textStyle25 = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static final textStyle30 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static final textStyle20n = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );
}
