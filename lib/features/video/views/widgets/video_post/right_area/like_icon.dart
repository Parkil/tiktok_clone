import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/view_models/video_post_vm.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/icon_text.dart';
import 'package:tiktok_clone/generated/l10n.dart';

/*
  state (plain, riverpod) 이 변경 되어 re-rendering 이 수행될 때 최소 단위는 widget
 */
class LikeIcon extends ConsumerWidget {
  final Future<void> Function() likeFunction;
  final VideoModel videoModel;

  const LikeIcon({
    required this.likeFunction,
    required this.videoModel,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoModelWatch =
        ref.watch(videoPostAsyncProvider(videoModel)).value!;

    return GestureDetector(
      onTap: likeFunction,
      child: IconText(
        iconData: FontAwesomeIcons.solidHeart,
        subText: S.of(context).likeCount(videoModelWatch.likes),
      ),
    );
  }
}
