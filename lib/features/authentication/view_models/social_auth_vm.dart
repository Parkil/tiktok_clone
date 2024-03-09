import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/util/utils.dart';

class SocialAuthVm extends AsyncNotifier<void> {
  late final AuthenticationRepo _authenticationRepo;

  @override
  FutureOr build() {
    _authenticationRepo = ref.read(authRepoProvider);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authenticationRepo.githubSignIn());

    if (state.hasError) {
      showFireBaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }
}

final socialAuthAsyncProvider = AsyncNotifierProvider<SocialAuthVm, void>(() => SocialAuthVm());
