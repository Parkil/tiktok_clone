import 'package:flutter/material.dart';

class VideoConfigCn extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfigCn = VideoConfigCn();
