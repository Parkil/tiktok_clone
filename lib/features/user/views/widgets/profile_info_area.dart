import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/user/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_button_area.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_description.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_following_area.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_user_info.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_user_link.dart';

class ProfileInfoArea extends ConsumerWidget {
  const ProfileInfoArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserProfileModel model = ref.watch(userProfileProvider).value!;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Gaps.v20,
          Avatar(
            hasAvatar: model.hasAvatar,
            name: model.name,
            uid: model.uid,
          ),
          Gaps.v20,
          ProfileUserInfo(name: model.name),
          Gaps.v24,
          const ProfileFollowingArea(),
          Gaps.v14,
          const ProfileButtonArea(),
          Gaps.v14,
          const ProfileDescription(),
          Gaps.v14,
          const ProfileUserLink(),
        ],
      ),
    );
  }
}
