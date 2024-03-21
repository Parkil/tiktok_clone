import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/icon_text.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class CommentIcon extends ConsumerWidget {
  final Future<void> Function(BuildContext context) commentFunction;
  final VideoModel videoModel;

  const CommentIcon({
    required this.commentFunction,
    required this.videoModel,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => commentFunction(context),
      child: IconText(
        iconData: FontAwesomeIcons.solidComment,
        subText: S.of(context).commentCount(videoModel.comments),
      ),
    );
  }
}
