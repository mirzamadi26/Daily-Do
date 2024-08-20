import 'package:daily_do/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: kGreenColor,
    scaffoldBackgroundColor: kWhiteColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
  );

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: kYellowColor,
      colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
      scaffoldBackgroundColor: kdarkModeBgColor.withOpacity(0.3));
}
