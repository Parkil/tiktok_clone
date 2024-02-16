import 'package:flutter/material.dart';
import 'package:tiktok_clone/config/theme/text_theme.dart';

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme(),





    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFFE9435A),
    ),
    // textTheme: GoogleFonts.robotoTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFFE9435A),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey.shade900,
      surfaceTintColor: Colors.grey.shade900,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.grey.shade700,
      labelColor: Colors.white54,
      indicatorColor: Colors.white,
    ),
    // iconTheme: IconThemeData( //FontAwsome Icon 추가 필요
    //   color: Colors.yellow,
    // ),
  );
}
