import 'package:flutter/material.dart';
import 'package:tiktok_clone/config/theme/text_theme.dart';
import 'package:tiktok_clone/constants/sizes.dart';

BottomAppBarTheme _bottomAppBarTheme() {
  return BottomAppBarTheme(
    surfaceTintColor: Colors.white,
    color: Colors.grey.shade50,
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: Sizes.size20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily(),
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme(),
    appBarTheme: _appBarTheme(),
    bottomAppBarTheme: _bottomAppBarTheme(),






    brightness: Brightness.light,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFFE9435A),
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFFE9435A),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    highlightColor: Colors.transparent,
    // tap 가능한 영역을 tab 했을때 표시 되는 색상
    splashColor: Colors.transparent,
    // tap 시 물결 효과 색상
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(splashFactory: NoSplash.splashFactory),
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.grey.shade500,
      labelColor: Colors.black,
      indicatorColor: Colors.black,
    ),
  );
}
