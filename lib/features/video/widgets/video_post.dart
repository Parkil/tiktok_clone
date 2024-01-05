import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final String videoUrl;

  const VideoPost({super.key, required this.onVideoFinished, required this.videoUrl});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {

  late VideoPlayerController _videoPlayerController;
  late bool isOnVideoFinishedCalled;

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
    isOnVideoFinishedCalled = false;
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    // setState 를 선언 하는 이유 : play 가 안되 어도 video 의 첫번째 프레임 이 표시가 되도록 하기 위해서
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.addListener(_onVideoChange);
    _videoPlayerController.play();
  }

  /*
  isCompleted 조건을 추가로 설정한 이유
  onChange 조건을 print 해보면 _videoPlayerController.value.duration == _videoPlayerController.value.position 조건이 충족 한 이후 에도 이 조건이 걸리는 경우가 있다
  그 경우 VideoTimelineScreen 의 next page 가 여러번 호출이 되게 되고 한 영상이 끝났는 데 다음다음 영상으로 넘어가는 경우가 생기게 된다
   */
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration == _videoPlayerController.value.position && !isOnVideoFinishedCalled) { // 비디오 재생 시간이 끝까지 가면
        widget.onVideoFinished(); // state 에서 widget 속성에 접근 하고자 하는 경우 이렇게 사용 가능
        isOnVideoFinishedCalled = true;
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
