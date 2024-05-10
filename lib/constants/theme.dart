import 'package:flutter/material.dart';
import 'package:note_taking/constants/colors.dart';


class Themes {
  static final light = ThemeData(
      primaryColor: AppColor.backgroundColor,
      colorScheme: const ColorScheme.light(surface: Colors.white),
      brightness: Brightness.light);
  static final dark = ThemeData(
      primaryColor: AppColor.darkGreyClr,
      colorScheme: const ColorScheme.dark(surface: AppColor.darkGreyClr),
      brightness: Brightness.dark);
}
