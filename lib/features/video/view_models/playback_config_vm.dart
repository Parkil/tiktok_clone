import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/video/models/playback_config_model.dart';
import 'package:tiktok_clone/features/video/repos/playback_config_repo.dart';

class PlayBackConfigVm extends Notifier<PlayBackConfigModel> {
  final PlayBackConfigRepo _repository;

  PlayBackConfigVm(this._repository);

  void setMuted(bool value) async {
    await _repository.setMuted(value);
    /*
      Notifier 에서 state 를 가지고 있음
      state 변경 사항을 적용 하려면 state 를 변경 하지 말고
      새로운 값을 가지는 state 를 새로 만들 어야 함
     */
    state = PlayBackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoPlay(bool value) async {
    await _repository.setAutoPlay(value);
    state = PlayBackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  // 해당 데이터 의 초기값 반환
  @override
  PlayBackConfigModel build() {
    return PlayBackConfigModel(
      muted: _repository.getMuted(),
      autoplay: _repository.getAutoPlay(),
    );
  }
}

/*
  repository(= shared preferences) 가 main 에서 설정 되기 때문에 여기 에서는
  empty 로 처리 하고 main 에서 override 처리 
 */
final playBackConfigProvider = NotifierProvider<PlayBackConfigVm, PlayBackConfigModel>(() {
  throw UnimplementedError();
});
