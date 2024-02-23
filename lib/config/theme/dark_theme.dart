import 'package:flutter/material.dart';
import 'package:tiktok_clone/config/theme/text_theme.dart';
import 'package:tiktok_clone/constants/sizes.dart';

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: Sizes.size20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: fontFamily(),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme(),
    appBarTheme: _appBarTheme(),




    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFFE9435A),
    ),
    // textTheme: GoogleFonts.robotoTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFFE9435A),
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
