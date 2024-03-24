import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/right_area/comment_icon.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/right_area/like_icon.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/right_area/share_icon.dart';
import 'package:tiktok_clone/util/avatar_util.dart';

class VideoPostRightArea extends ConsumerWidget {
  final Future<void> Function(BuildContext context) commentFunction;
  final Future<void> Function() likeFunction;
  final VideoModel videoModel;

  const VideoPostRightArea({
    super.key,
    required this.commentFunction,
    required this.videoModel,
    required this.likeFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserProfileModel model = ref.watch(userProfileProvider).value!;
    debugPrint("uid : ${model.name}");
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
              model.name,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Gaps.v24,
          LikeIcon(likeFunction: likeFunction, videoModel: videoModel),
          Gaps.v24,
          CommentIcon(commentFunction: commentFunction, videoModel: videoModel),
          Gaps.v24,
          const ShareIcon(),
        ],
      ),
    );
  }
}
