import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/repos/videos_repo.dart';

// FamilyAsyncNotifier : build 시 외부 파라 메터를 받을 수 있게 처리
class VideoPostVm extends FamilyAsyncNotifier<VideoModel, VideoModel> {
  late final VideosRepo _videosRepo;
  late final VideoModel _videoModel;

  @override
  FutureOr<VideoModel> build(VideoModel arg) {
    _videoModel = arg;
    _videosRepo = ref.read(videosRepoProvider);
    return _videoModel;
  }

  Future<void> toggleLikeVideo() async {
    final uid = ref.read(userProfileProvider).value!.uid;
    await _videosRepo.toggleLikeVideo(_videoModel.id, uid);
    await _videosRepo.onLikeToggleEventListener(_videoModel.id, _toggleLikeCallback);
  }


  /*
    현재 구조
    1._videosRepo.toggleLikeVideo
    2.cloud function 에서 video doc like 업데이트
    3.변경을 감지 해서 video_repo 에서 _toggleLikeCallback 호출
    4.state 변경

    단점
    1. cloud function 이 실행되고 변경을 감지하기 까지 시간 차가 있다 보니 like count 가 늦게 update 된다
    2. firestore 의 사용량이 크게 올라간다 ( like 자체가 페이지 이동 없이 버튼만 누르면 되는 구조 )

    페이지가 이동되면서 변경을 감지하는 경우에는 현재 방식을 써도 큰 상관이 없다
    ex) 현재 비디오 업로드시 썸네일생성을 cloud function 에서 처리하는데 이를 감지하지 못하다 보니 업로드 후 home 화면으로 이동하면 흰화면만 보임

    그러나 like 처럼 한 사용자가 빠른 시간내에 여러번 누를 수 있는 기능의 경우에는 위 방식이 적절치 않아 보인다

    지금 드는 생각은 count 자체는 배치나 기타 방법을 이용하여 주기적으로 가져오고 like 처리 여부는 사용자에 관련된 데이터이니 상대적으로 데이터 크기가
    작을 테니 바로 처리


   */
  Future<void> _toggleLikeCallback(Map<String, dynamic> trackData) async {
    state = AsyncValue.data(VideoModel.fromJson(trackData));
  }
}

final videoPostAsyncProvider = AsyncNotifierProvider.family<VideoPostVm, VideoModel, VideoModel>(() => VideoPostVm());
