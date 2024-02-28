import 'package:flutter/material.dart';

// InheritedWidget 자체 에서는 data 의 변경이 불가능 하기 때문에 StatefulWidget 과 연계 하여 사용
class VideoConfigData extends InheritedWidget {
  final bool autoMute;
  final void Function() toggleMuted;

  const VideoConfigData({
    super.key,
    required super.child,
    required this.autoMute,
    required this.toggleMuted,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void _toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      toggleMuted: _toggleMuted,
      autoMute: autoMute,
      child: widget.child,
    );
  }
}
