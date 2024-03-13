import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/user/models/user_following_model.dart';

// 현재는 Notifier 를 쓰지만 나중에 FireBase 나 외부 API 를 사용 하게 되면 AsyncNotifier 로 변경
class UserFollowingVm extends Notifier<UserFollowingModel> {
  @override
  UserFollowingModel build() {
    return UserFollowingModel(
      followers: 0,
      following: 0,
      likes: 0,
    );
  }

  void updateFollowingInfo({
    int? followers,
    int? following,
    int? likes,
  }) {
    UserFollowingModel currentModel = state;
    state = currentModel.copyWith(
      followers: followers,
      following: following,
      likes: likes,
    );
  }
}

final userFollowingProvider =
    NotifierProvider<UserFollowingVm, UserFollowingModel>(
        () => UserFollowingVm());
