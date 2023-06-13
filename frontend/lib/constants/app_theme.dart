import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

final appTheme = ThemeData(
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    titleSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
    labelMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
  ),
  primaryColor: AppColor.secondary,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColor.formColor,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
  ),
);
