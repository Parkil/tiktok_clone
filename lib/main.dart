import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

import 'constants/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 휴대폰 회전 기능 설정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 배터리, 네트워크 상태 아이콘 색상 설정
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 자주 사용 하는 widget 의 경우 여기 에서 style 을 일괄 로 적용해 두는 것이 효율적
    return MaterialApp(
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      // system 의 설정을 그대로 따라감
      debugShowCheckedModeBanner: true,
      /*
        Tip. 특정 widget 에서 color 를 지정 하는 옵션이 없다고 해도 main theme 에서 color 를 변경해 주면 해당 color 를 따라 간다
       */
      theme: ThemeData(
        /*
        text theme 을 설정 하는 방법 1 - TextTheme 객체를 직접 선언
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
            fontSize: 96,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5
          ),
          displayMedium: GoogleFonts.openSans(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5
          ),
          displaySmall: GoogleFonts.openSans(
            fontSize: 48,
            fontWeight: FontWeight.w400
          ),
          headlineMedium: GoogleFonts.openSans(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25
          ),
          headlineSmall: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w400
          ),
          titleLarge: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15
          ),
          titleMedium: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15
          ),
          titleSmall: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25
          ),
          labelLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4
          ),
          labelSmall: GoogleFonts.roboto(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5
          ),
        ),*/

        // textTheme 을 설정 하는 두번째 방법 https://fonts.google.com/ 에서 검색한 font 의 Theme 을 호출 하는 방법(사이트 에 있는 모든 폰트를 지원 하는건 아님)
        // textTheme: GoogleFonts.robotoTextTheme(),
        // Typography font, color 만 설정된 TextTheme,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        highlightColor: Colors.transparent,
        // tap 가능한 영역을 tab 했을때 표시 되는 색상
        splashColor: Colors.transparent,
        // tap 시 물결 효과 색상
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
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
      ),
      // home: const SignUpScreen(),
      home: const MainNavigationScreen(),
      // home: const SignUpScreen() // home 으로 지정된 widget 의 경우 scaffold 의 뒤로 가기 버튼이 사라 진다
    );
  }
}
