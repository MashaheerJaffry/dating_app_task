import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simply_poem/utils/constants/pallete.dart';

class StyleConstants {
  StyleConstants._();
  static const buttonRadius = Radius.circular(8);
  static final borderRadius = BorderRadius.circular(8);

  static final TextStyle headerTextStyle = GoogleFonts.poppins(
    color: Pallete.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}
