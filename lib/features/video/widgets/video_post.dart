import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  const VideoPost({super.key, required this.onVideoFinished});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() {
    _videoPlayerController = VideoPlayerController.asset("assets/videos/video.mp4");
    _videoPlayerController.addListener(_onVideoChange);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.play();
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) { // video controller 가 초기화 되어 있고
      if (_videoPlayerController.value.duration == _videoPlayerController.value.position) { // 비디오 재생 시간이 끝까지 가면
        widget.onVideoFinished(); // state 에서 widget 속성에 접근 하고자 하는 경우 이렇게 사용 가능
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : Container(color: Colors.black))
      ],
    );
  }

}
