import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.cairo(
        fontSize: 48.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get displayMedium => GoogleFonts.cairo(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get displaySmall => GoogleFonts.cairo(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineLarge => GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineMedium => GoogleFonts.cairo(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get headlineSmall => GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleLarge => GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMedium => GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmall => GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyLarge => GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodySmall => GoogleFonts.cairo(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get labelLarge => GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelMedium => GoogleFonts.cairo(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelSmall => GoogleFonts.cairo(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      );
}
