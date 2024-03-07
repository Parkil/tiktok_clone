import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

void showFireBaseErrorSnack(BuildContext context, Object? error) {
  final snack = SnackBar(
    showCloseIcon: true,
    content: Text(
      (error as FirebaseException).message ?? "Something went wrong",
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
