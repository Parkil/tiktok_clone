import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/config/theme/dark_theme.dart';
import 'package:tiktok_clone/config/theme/light_theme.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

import 'features/main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 휴대폰 회전 기능 설정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 배터리, Network 상태 아이콘 색상 설정
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: true,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const SignUpScreen(),
      // home: const MainNavigationScreen(),
    );
  }
}

