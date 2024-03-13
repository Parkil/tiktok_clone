import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/repos/user_repo.dart';

class UserProfileVm extends AsyncNotifier<UserProfileModel> {

  late final UserRepo _userRepo;
  late final AuthenticationRepo _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepoProvider);
    _authRepo = ref.read(authRepoProvider);

    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      } else {
        return UserProfileModel.empty();
      }
    } else {
      return UserProfileModel.empty();
    }
  }

  Future<void> createProfile(UserCredential credential, Map<dynamic, dynamic> signUpState) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final user = credential.user!;
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: 'undefined',
      link: 'undefined',
      uid: user.uid,
      name: signUpState['username'] ?? "Anon",
      email: signUpState['email'] ?? 'anon@anon.com'
    );
    await _userRepo.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> findProfile(String uid) async {
    state = const AsyncValue.loading();
  }

  Future<void> onAvatarUpload() async {
    UserProfileModel model = state.value!;
    state = AsyncValue.data(model.copyWith(hasAvatar: true));
    await _userRepo.updateUser(model.uid, {"hasAvatar": true});
  }
}

final userProfileProvider = AsyncNotifierProvider<UserProfileVm, UserProfileModel>(() {
  return UserProfileVm();
});
