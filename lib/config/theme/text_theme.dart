import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';

String? fontFamily() {
  return GoogleFonts.poppins().fontFamily;
}

/*
  TextTheme 을 사용 하니까 발생되는 문제중 하나가 copyWith 로 FontWeight 를 조절하려고 하면 조절이 되지 않는 문제가 발생함
 */
TextTheme textTheme() {
  return TextTheme(
    displayMedium: GoogleFonts.poppins(
      fontSize: Sizes.size40,
      fontWeight: FontWeight.w600
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: Sizes.size20,
      fontWeight: FontWeight.w300
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: Sizes.size28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: Sizes.size24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: Sizes.size20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: Sizes.size16,
      letterSpacing: 0.1
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: Sizes.size16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: Sizes.size14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: Sizes.size12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: Sizes.size16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.25
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: Sizes.size14,
      color: const Color(0xFFE9435A),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1
    ),
  );
}
