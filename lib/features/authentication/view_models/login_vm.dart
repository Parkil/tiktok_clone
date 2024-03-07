import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/util/utils.dart';

class LoginVm extends AsyncNotifier<void> {
  late final AuthenticationRepo _authenticationRepo;

  @override
  FutureOr<void> build() {
    _authenticationRepo = ref.read(authRepoProvider);
  }

  Future<void> login(String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () async => await _authenticationRepo.signIn(email, password));

    // todo 이부분은 signup_screen 으로 이동
    if (state.hasError) {
      showFireBaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }
}

final loginStateAsyncProvider =
    AsyncNotifierProvider<LoginVm, void>(() => LoginVm());
