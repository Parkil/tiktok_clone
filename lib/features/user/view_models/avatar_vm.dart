import 'dart:async';
import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/user/repos/user_repo.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';

class AvatarVm extends AsyncNotifier<void> {
  late final UserRepo _userRepo;

  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userRepoProvider);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepoProvider).user!.uid;
    state = await AsyncValue.guard(() async {
      await _userRepo.uploadAvatar(file, fileName);
      await ref.read(userProfileProvider.notifier).onAvatarUpload();
    });
  }
}

final avatarAsyncProvider = AsyncNotifierProvider<AvatarVm, void>(() => AvatarVm());
