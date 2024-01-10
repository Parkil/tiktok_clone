import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/video/widgets/animated_video_button.dart';
import 'package:tiktok_clone/features/video/widgets/video_comments.dart';
import 'package:tiktok_clone/features/video/widgets/video_post_bottom_info.dart';
import 'package:tiktok_clone/features/video/widgets/video_post_right_info.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final String videoUrl;
  final int index;

  const VideoPost(
      {super.key,
      required this.onVideoFinished,
      required this.videoUrl,
      required this.index});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;
  late bool isOnVideoFinishedCalled;
  bool _isPaused = false;

  get _animationDuration => const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    // lowerBound: animation 최소 크기, upperBound: animation 최대 크기, value: animation 기본값
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 1.0,
        upperBound: 1.5,
        value: 1.5,
        duration: _animationDuration);
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
    _videoPlayerController.setLooping(true);
  }

  /*
  isCompleted 조건을 추가로 설정한 이유
  onChange 조건을 print 해보면 _videoPlayerController.value.duration == _videoPlayerController.value.position 조건이 충족 한 이후 에도 이 조건이 걸리는 경우가 있다
  그 경우 VideoTimelineScreen 의 next page 가 여러번 호출이 되게 되고 한 영상이 끝났는 데 다음 다음 영상 으로 넘어 가는 경우가 생기게 된다
   */
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
              _videoPlayerController.value.position &&
          !isOnVideoFinishedCalled) {
        // 비디오 재생 시간이 끝까지 가면
        widget.onVideoFinished(); // state 에서 widget 속성에 접근 하고자 하는 경우 이렇게 사용 가능
        isOnVideoFinishedCalled = true;
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _togglePlay() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // value -> lowerBound
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lowerBound -> value
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapComment(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _togglePlay();
    }

    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true, // bottom sheet child 가 scroll 이 가능한 widget 일때 true 로 설정
        context: context, builder: (context) => const VideoComments());

    // showModalBottomSheet 가 닫히면 await showModalBottomSheet 다음 로직이 실행 된다
    _togglePlay();
  }

  /*
     VisibilityDetector
     widget 이 이동시 이전-현재 widget 이 이동한 정도를 체크 하는 API
   */
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
              child: _videoPlayerController.value.isInitialized
                  ? VideoPlayer(_videoPlayerController,
                      key: Key("${widget.index}"))
                  : Container(color: Colors.black)),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePlay,
            ),
          ),
          AnimatedVideoButton(
              animationController: _animationController,
              isPaused: _isPaused,
              animationDuration: _animationDuration),
          const VideoPostBottomInfo(
              loginUser: "@로그인한 사람",
              description: "aaabbbcccdddddddd",
              tag:
                  "#123, #3333333, #55555555, #444444444444, #444444444444, #444444444444"),
          VideoPostRightInfo(commentFunction: _onTapComment),
        ],
      ),
    );
  }
}
