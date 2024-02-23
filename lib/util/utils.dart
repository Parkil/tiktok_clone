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

bool isNavTabDarkMode(BuildContext context, int selIdx) {
  return selIdx == 0 || isDarkMode(context);
}
