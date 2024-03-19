import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/icon_text.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/util/avatar_util.dart';

class VideoPostRightArea extends ConsumerWidget {
  final Future<void> Function(BuildContext context) commentFunction;
  final Future<void> Function() likeFunction;
  final VideoModel videoData;

  const VideoPostRightArea({
    super.key,
    required this.commentFunction,
    required this.videoData,
    required this.likeFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserProfileModel model = ref.watch(userProfileProvider).value!;

    return Positioned(
      bottom: 20,
      right: 10,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            foregroundImage: NetworkImage(
              avatarImageUrl(model.uid),
            ),
            child: Text(
              videoData.creator,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Gaps.v24,
          GestureDetector(
            onTap: likeFunction,
            child: IconText(
              iconData: FontAwesomeIcons.solidHeart,
              subText: S.of(context).likeCount(videoData.likes),
            ),
          ),
          Gaps.v24,
          GestureDetector(
            onTap: () => commentFunction(context),
            child: IconText(
              iconData: FontAwesomeIcons.solidComment,
              subText: S.of(context).commentCount(videoData.comments),
            ),
          ),
          Gaps.v24,
          const IconText(
            iconData: FontAwesomeIcons.share,
            subText: "Share",
          ),
        ],
      ),
    );
  }
}
