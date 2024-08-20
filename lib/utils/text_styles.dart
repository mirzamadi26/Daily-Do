import 'package:daily_do/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle labelTextStyle() => GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w400, color: kBlackColor);
  static TextStyle appBarTextStyle() => GoogleFonts.dmSans(
      fontSize: 33, fontWeight: FontWeight.w500, color: kBlackColor);
  static TextStyle labelInterTextStyle() => GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: kBlackColor);
  static TextStyle appBarInterTextStyle() => GoogleFonts.inter(
      fontSize: 33, fontWeight: FontWeight.w500, color: kBlackColor);
  static TextStyle labelPoppinsTextStyle() => GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w500, color: kBlackColor);
  static TextStyle labelStyleText() => GoogleFonts.pacifico(
      fontSize: 14, fontWeight: FontWeight.w400, color: kBlackColor);
}
