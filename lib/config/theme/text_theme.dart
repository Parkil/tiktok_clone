import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';

TextTheme textTheme() {
  return TextTheme(
    displaySmall: GoogleFonts.poppins(
      fontSize: Sizes.size48,
      fontWeight: FontWeight.w400
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
      fontSize: Sizes.size16,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: Sizes.size18,
      fontWeight: FontWeight.w500,
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
