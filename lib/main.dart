import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

import 'constants/sizes.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 자주 사용 하는 widget 의 경우 여기 에서 style 을 일괄 로 적용해 두는 것이 효율적
    return MaterialApp(
      title: 'TikTok Clone',
      /*
        Tip. 특정 widget 에서 color 를 지정 하는 옵션이 없다고 해도 main theme 에서 color 를 변경해 주면 해당 color 를 따라 간다
       */
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      home: const MainNavigationScreen(),
      // home: const SignUpScreen() // home 으로 지정된 widget 의 경우 scaffold 의 뒤로 가기 버튼이 사라 진다
    );
  }
}


