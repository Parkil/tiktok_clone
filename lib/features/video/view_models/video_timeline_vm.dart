import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/repos/videos_repo.dart';

class VideoTimeLineVm extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepo _videosRepo;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepo = ref.read(videosRepoProvider);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    // AsyncValue.loading() 을 안쓰는 이유 : AsyncValue.loading() 을 호출 하면 전체 페이지 를 로딩 하는 로직이 video_timeline_screen 에 들어가 있어서
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final rawData =
        await _videosRepo.fetchVideos(lastItemCreatedAt: lastItemCreatedAt);
    return rawData.docs.map((doc) => VideoModel.fromJson(doc.data())).toList();
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final videoTimeLineProvider =
    AsyncNotifierProvider<VideoTimeLineVm, List<VideoModel>>(() {
  return VideoTimeLineVm();
});
