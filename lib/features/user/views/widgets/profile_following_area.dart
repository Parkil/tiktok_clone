import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/view_models/user_following_vm.dart';
import 'package:tiktok_clone/features/user/views/widgets/custom_divider.dart';
import 'package:tiktok_clone/features/user/views/widgets/following_info.dart';

class ProfileFollowingArea extends ConsumerWidget {
  const ProfileFollowingArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userFollowingProvider);

    return SizedBox(
      height: Sizes.size52, // VerticalDivider 는 height 를 필요로 함
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FollowingInfo(count: model.followers, label: "Followers"),
          const CustomDivider(),
          FollowingInfo(count: model.following, label: "Following"),
          const CustomDivider(),
          FollowingInfo(count: model.likes, label: "Likes"),
        ],
      ),
    );
  }
}
