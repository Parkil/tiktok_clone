import 'package:shared_preferences/shared_preferences.dart';

class PlayBackConfigRepo {

  static const _autoPlay = "autoPlay";
  static const _mute = "mute";

  final SharedPreferences _preferences;

  PlayBackConfigRepo(this._preferences);

  Future<void> setMuted(bool isMuted) async {
    _preferences.setBool(_mute, isMuted);
  }

  Future<void> setAutoPlay(bool autoPlay) async {
    _preferences.setBool(_autoPlay, autoPlay);
  }

  bool getMuted() {
    return _preferences.getBool(_mute) ?? false;
  }

  bool getAutoPlay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }
}
