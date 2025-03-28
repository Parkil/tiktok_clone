import 'package:flutter/material.dart';

class VideoConfigCnProvider extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}
