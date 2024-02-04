import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/config/theme/brand_theme.dart';


final FlexSchemeColor _schemeDark = FlexSchemeColor.from(
  primary: Colors.grey.shade500,
  secondary: Colors.red,
  tertiary: const Color(0xFFE9435A),
  brightness: Brightness.light,
);


const double _appBarElevation = 0.5;
const double _appBarOpacity = 0.94;
const bool _swapColors = false;
const int _usedColors = 6;

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

final FlexTones _flexTonesDark = FlexTones.material(Brightness.dark);
final String? _fontFamily = GoogleFonts.notoSans().fontFamily;
const TextTheme _textTheme = TextTheme(
  displayMedium: TextStyle(fontSize: 41),
  displaySmall: TextStyle(fontSize: 36),
  labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
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

const BrandTheme darkBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 167, 227, 218),
);


ThemeData darkTheme() {
  return FlexThemeData.dark(
    useMaterial3: true,
    colors: _schemeDark,
    swapColors: _swapColors,
    usedColors: _usedColors,
    darkIsTrueBlack: false,
    appBarStyle: FlexAppBarStyle.primary, // Try styles like: FlexAppBarStyle.background,
    appBarElevation: _appBarElevation,
    appBarOpacity: _appBarOpacity,
    transparentStatusBar: _transparentStatusBar,
    tabBarStyle: _tabBarForAppBar,
    surfaceMode: _surfaceMode,
    blendLevel: _blendLevel,
    tooltipsMatchBackground: _tooltipsMatchBackground,
    fontFamily: _fontFamily,
    textTheme: _textTheme,
    primaryTextTheme: _textTheme,
    keyColors: _keyColors,
    tones: _flexTonesDark,
    subThemesData: _useSubThemes ? _subThemesData : null,
    visualDensity: _visualDensity,
    platform: _platform,
    // Add all our custom theme extensions, in this case we only have one.
    extensions: <ThemeExtension<dynamic>>{
      darkBrandTheme,
    },
  );
}
