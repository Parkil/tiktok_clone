import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/video/view_models/playback_config_vm.dart';

class VideoVolumeButton extends ConsumerWidget {
  final void Function() onTap;

  const VideoVolumeButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool muted = ref.watch(playBackConfigProvider).muted;

    return GestureDetector(
      onTap: onTap,
      child: muted
          ? const FaIcon(
              FontAwesomeIcons.volumeOff,
              color: Colors.white,
            )
          : const FaIcon(
              FontAwesomeIcons.volumeHigh,
              color: Colors.white,
            ),
    );
  }
}
