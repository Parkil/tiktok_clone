import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../view_models/playback_config_vm.dart';

class VideoVolumeButton extends StatelessWidget {
  final void Function() onTap;

  const VideoVolumeButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: context.watch<PlayBackConfigVm>().muted
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
