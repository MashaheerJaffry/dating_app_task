// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

import '../utils/constants/pallete.dart';

class ButtonWidget extends StatelessWidget {
  final text;
  double? width;
  double? height;
  Color? color;
  VoidCallback onTap;
  ButtonWidget(
      {super.key,
      required this.text,
      this.width,
      this.height,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    height = height ?? 56.h;
    width = width ?? 336.w;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Pallete.blue,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.h),
            child: Text(text, style: StyleConstants.headerTextStyle),
          ),
        ),
      ),
    );
  }
}

class SecondaryButtonWidget extends StatelessWidget {
  SecondaryButtonWidget({required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x723D92).withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.h),
          child: Text(
            text,
            style: GoogleFonts.mulish(
              color: Color(0xff723D92),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.045,
            ),
          ),
        ),
      ),
    );
  }
}
