import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/util/utils.dart';

class SignUpVm extends AsyncNotifier<void> {
  late final AuthenticationRepo _authenticationRepo;

  @override
  FutureOr build() {
    _authenticationRepo = ref.read(authRepoProvider);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final provider = ref.read(signUpStateProvider);
    state = await AsyncValue.guard(
      () async => await _authenticationRepo.signUp(
        provider['email'],
        provider['password'],
      ),
    );

    // todo 이부분은 birthday_screen 으로 이동
    if (state.hasError) {
      showFireBaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

// StateProvider : 단순한 상태(= data) 조회용 provider
final signUpStateProvider = StateProvider((ref) => {});

final signUpAsyncProvider = AsyncNotifierProvider<SignUpVm, void>(() => SignUpVm());
