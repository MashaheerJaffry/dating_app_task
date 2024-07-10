// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

import '../utils/constants/pallete.dart';

class AuthTextField extends StatelessWidget {
  bool obsecureText;
  final text;
  TextEditingController controller;
  AuthTextField(
      {super.key,
      required this.obsecureText,
      required this.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 318.w,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        style: StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Pallete.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.3,
          ),
          filled: true,
          fillColor: Pallete.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
            borderSide: BorderSide(
              width: 3.w,
              color: Colors.red,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class EditTextField extends StatelessWidget {
  EditTextField(
      {super.key,
      required this.obsecureText,
      required this.text,
      required this.controller});

  bool obsecureText;
  final text;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.3,
      ),
      obscureText: obsecureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.3,
        ),
        // prefixIcon: Image.asset(icon),
        filled: true,
        fillColor: Pallete.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide(
            width: 3.w,
            color: Pallete.red,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
