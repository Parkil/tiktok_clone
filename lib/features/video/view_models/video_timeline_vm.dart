import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';

class VideoTimeLineVm extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    VideoModel(
      title: "First Video",
      description: '',
      fileUrl: '',
      thumbnailUrl: '',
      likes: 0,
      comments: 0,
      creatorUid: '',
      createdAt: 0,
      creator: '',
    ),
  ];

  void uploadVideo() async {
    state = const AsyncValue.loading(); // AsyncNotifier 의 상태를 loading 으로 변경
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(
      title: "${DateTime.now()}",
      description: '',
      fileUrl: '',
      thumbnailUrl: '',
      likes: 0,
      comments: 0,
      creatorUid: '',
      createdAt: 0,
      creator: '',
    );
    // model 의 데이터 가 새로 생성되 어야 notifier 가 작동
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final videoTimeLineProvider =
    AsyncNotifierProvider<VideoTimeLineVm, List<VideoModel>>(() {
  return VideoTimeLineVm();
});
