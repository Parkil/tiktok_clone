import 'package:flutter/cupertino.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

Color switchColor({
  required bool condition,
  required Color matchedColor,
  required Color altColor,
}) {
  return condition ? matchedColor : altColor;
}

bool checkNavTabDarkMode(BuildContext context, String tabName) {
  return tabName == 'home' || isDarkMode(context);
}
