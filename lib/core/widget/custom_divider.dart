import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDivider {
  CustomDivider._();
  static Container horizontal({
    Color? color,

    /// default is 5 percent of the screen width
    double? width,

    /// default is 5 percent of the screen width
    double? thickness,
  }) {
    return Container(
      width: width ?? 5.w,
      height: thickness ?? .5.w,
      margin: const EdgeInsetsDirectional.only(start: 1, end: 1),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.sp),
      ),
    );
  }

  static Container vertical({
    Color? color = Colors.black,

    /// default is 5 percent of the screen height
    double? height,
  }) {
    return Container(
      width: .5.w,
      height: height ?? 5.h,
      margin: const EdgeInsetsDirectional.only(start: 1, end: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.sp),
      ),
    );
  }
}
