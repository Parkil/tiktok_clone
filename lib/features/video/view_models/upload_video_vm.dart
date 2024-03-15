import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/repos/videos_repo.dart';
import 'package:tiktok_clone/util/utils.dart';

class UploadVideoVm extends AsyncNotifier<void> {
  late final VideosRepo _videosRepo;

  @override
  FutureOr<void> build() {
    _videosRepo = ref.read(videosRepoProvider);
  }

  Future<void> uploadVideo(File file, BuildContext context) async {
    UserProfileModel model = ref.read(userProfileProvider).value!;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final TaskSnapshot task = await _videosRepo.uploadVideo(file, model.uid);

      if (task.metadata != null) {
        final uploadModel = VideoModel(
          title: 'title',
          description: 'desc',
          fileUrl: await task.ref.getDownloadURL(),
          thumbnailUrl: '',
          likes: 0,
          comments: 0,
          creatorUid: model.uid,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          creator: model.name,
        );

        await _videosRepo.saveVideo(uploadModel);
      }
    });

    if (!state.hasError) {
      context.go("/home");
    } else {
      showFireBaseErrorSnack(context, state.error);
    }
  }
}

final uploadVideoAsyncProvider =
    AsyncNotifierProvider<UploadVideoVm, void>(() => UploadVideoVm());
