import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'brand_theme.dart';





const double _appBarElevation = 0.5;
const double _appBarOpacity = 0.94;



const FlexKeyColors _keyColors = FlexKeyColors(
  useKeyColors: false,
  // <-- set to true enable M3 seeded ColorScheme.
  useSecondary: true,
  useTertiary: true,
  keepPrimary: false,
  // <-- Keep defined value, do not use the seeded result.
  keepPrimaryContainer: false,
  keepSecondary: false,
  keepSecondaryContainer: false,
  keepTertiary: false,
  keepTertiaryContainer: false,
);

final FlexTones _flexTonesLight = FlexTones.material(Brightness.light);

const TextTheme _textTheme = TextTheme(
  displayMedium: TextStyle(fontSize: 41),
  displaySmall: TextStyle(fontSize: 36),
  labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
);

const BrandTheme lightBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 8, 79, 71),
);

final TargetPlatform _platform = defaultTargetPlatform;

const bool _useSubThemes = true;
final VisualDensity _visualDensity =
    FlexColorScheme.comfortablePlatformDensity;

const FlexSubThemesData _subThemesData = FlexSubThemesData(
  interactionEffects: true,

  defaultRadius: null,
  bottomSheetRadius: 24,

  useTextTheme: true,

  inputDecoratorBorderType: FlexInputBorderType.outline,
  inputDecoratorIsFilled: true,
  inputDecoratorUnfocusedHasBorder: false,
  inputDecoratorSchemeColor: SchemeColor.primary,
  inputDecoratorBackgroundAlpha: 20,

  chipSchemeColor: SchemeColor.primary,

  elevatedButtonElevation: 1,
  thickBorderWidth: 1.5,
  // Default is 2.0.
  thinBorderWidth: 1,
  // Default is 1.0.

  bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,

  bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
);

const bool _tooltipsMatchBackground = true;
const int _blendLevel = 20;
const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highBackgroundLowScaffold;
const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;
const bool _transparentStatusBar = true;

// ==============================================

final String? _fontFamily = GoogleFonts.poppins().fontFamily;

/*
  FlexSchemeColor / FlexScheme
  2개다 color 를 사전 정의 해서 이를 사용 하기 위함
  차이점 은 FlexScheme 은 사전에 정의 된 scheme 을 가져다 쓰는 거고
  FlexSchemeColor 는 사용자 가 color 를 직접 정의할 수 있는 정도?

  2개를 동시에 사용은 안됨

  bottomAppBar 처럼 기본적 으로 color 를 가지는 widget 에 해당 색상이 적용됨

  cursorColor: Color(0xFFE9435A), -> Tiktok Primary Color
 */
const bool _useSchemeColor = true;
final FlexSchemeColor _schemeLight = FlexSchemeColor.from(
  primary: Colors.grey.shade500,
  secondary: Colors.red,
  tertiary: const Color(0xFFE9435A),
  brightness: Brightness.light,
);

const FlexScheme _scheme = FlexScheme.flutterDash;

// 색상을 섞을때 사용
const int _usedColors = 6;
const bool _swapColors = false;

ThemeData lightTheme() {
  return FlexThemeData.light(
    useMaterial3: true,
    fontFamily: _fontFamily,
    colors: _schemeLight,
    swapColors: _swapColors, // If true, swap primary and secondaries.
    usedColors: _usedColors,
    lightIsWhite: true, // light mode 에서 흰색을 선명 하게 표시

    appBarStyle: null,
    // Try different style, e.g.FlexAppBarStyle.primary,
    appBarElevation: _appBarElevation,
    appBarOpacity: _appBarOpacity,
    transparentStatusBar: _transparentStatusBar,
    tabBarStyle: _tabBarForAppBar,
    surfaceMode: _surfaceMode,
    blendLevel: _blendLevel,
    tooltipsMatchBackground: _tooltipsMatchBackground,
    textTheme: _textTheme,
    primaryTextTheme: _textTheme,
    keyColors: _keyColors,
    tones: _flexTonesLight,
    subThemesData: _useSubThemes ? _subThemesData : null,
    visualDensity: _visualDensity,
    platform: _platform,
    // Add all our custom theme extensions, in this case we only have one.
    extensions: <ThemeExtension<dynamic>>{
      lightBrandTheme,
    },
  );
}
