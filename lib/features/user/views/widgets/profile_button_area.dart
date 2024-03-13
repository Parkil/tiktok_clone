import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/view_models/user_following_vm.dart';
import 'package:tiktok_clone/util/utils.dart';

class ProfileButtonArea extends ConsumerWidget {
  const ProfileButtonArea({super.key});

  _following(WidgetRef ref) {
    final currentFollowers = ref.read(userFollowingProvider).followers;
    ref.read(userFollowingProvider.notifier).updateFollowingInfo(followers: currentFollowers + 1);
  }

  _like(WidgetRef ref) {
    final currentLikes = ref.read(userFollowingProvider).likes;
    ref.read(userFollowingProvider.notifier).updateFollowingInfo(likes: currentLikes + 1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: Sizes.size48,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _following(ref),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size16,
                horizontal: Sizes.size64,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.size4),
                ),
              ),
              child: const Text(
                "Follow",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Gaps.h8,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: Sizes.size1,
              ),
              color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
            ),
            child: const Center(
              child: FaIcon(FontAwesomeIcons.youtube),
            ),
          ),
          Gaps.h8,
          GestureDetector(
            onTap: () => _like(ref),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: Sizes.size1,
                ),
                color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.angleDown),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
