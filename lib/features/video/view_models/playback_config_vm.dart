import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/video/models/playback_config_model.dart';
import 'package:tiktok_clone/features/video/repos/playback_config_repo.dart';

class PlayBackConfigVm extends ChangeNotifier {

  final PlayBackConfigRepo _repository;
  late final PlayBackConfigModel _model = PlayBackConfigModel(muted: _repository.getMuted(), autoplay: _repository.getAutoPlay());

  PlayBackConfigVm(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    _model.autoplay = value;
    notifyListeners();
  }

  bool get muted {
    return _model.muted;
  }

  bool get autoplay {
    return _model.autoplay;
  }
}
