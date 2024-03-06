import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/config/theme/dark_theme.dart';
import 'package:tiktok_clone/config/theme/light_theme.dart';
import 'package:tiktok_clone/features/video/repos/playback_config_repo.dart';
import 'package:tiktok_clone/features/video/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // 휴대폰 회전 기능 설정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 배터리, Network 상태 아이콘 색상 설정
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  final preferences = await SharedPreferences.getInstance();
  final repository = PlayBackConfigRepo(preferences);

  runApp(
    ProviderScope(
      overrides: [
        playBackConfigProvider.overrideWith(() => PlayBackConfigVm(repository))
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 자주 사용 하는 widget 의 경우 여기 에서 style 을 일괄 로 적용해 두는 것이 효율적
    return MaterialApp.router(
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: true,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],
      routerConfig: ref.watch(routerProvider),
    );
  }
}
