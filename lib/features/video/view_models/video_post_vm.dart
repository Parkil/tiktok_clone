import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/video/repos/videos_repo.dart';

// FamilyAsyncNotifier : build 시 외부 파라 메터를 받을 수 있게 처리
class VideoPostVm extends FamilyAsyncNotifier<void, String> {
  late final VideosRepo _videosRepo;
  late final String _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _videosRepo = ref.read(videosRepoProvider);
  }

  Future<void> likeVideo() async {
    final uid = ref.read(userProfileProvider).value!.uid;
    await _videosRepo.likeVideo(_videoId, uid);
  }
}

final videoPostAsyncProvider = AsyncNotifierProvider.family<VideoPostVm, void, String>(() => VideoPostVm());
