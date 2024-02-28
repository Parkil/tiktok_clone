import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/features/video/widgets/video_post/animated_video_button.dart';
import 'package:tiktok_clone/features/video/widgets/video_comment/video_comments.dart';
import 'package:tiktok_clone/features/video/widgets/video_post/video_post_bottom_area.dart';
import 'package:tiktok_clone/features/video/widgets/video_post/video_post_right_area.dart';
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
  bool _isMuted = false;

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

  /*
    sound 가 들어가 있는 동영상 의 경우 웹에서 자동 재생을 허용 하지 않는 다고 하는데
    이에 대해 확인해 볼 필요가 있다

    실제로 sound 가 들어가 있는 동영상 으로 확인 해본 바로 는 sound 를 mute 하지 않고
    동영상 을 재생 하면 정상적 으로 진행 되지 않는 경우가 많다

    그리고 타 사이트 를 봐도 web 에서 sound 가 있는 동영상 을 재생 하는 경우 에는 mute 가 되어서 표시가 됨
    참고 url : https://www.pexels.com/search/videos/sound/

    유튜브 의 경우
      메인 / 검색 페이지 에서 동영상 으로 넘어 가는 경우 - 바로 재생
      동영상 화면 에서 F5를 누르 거나 url 입력 으로 바로 가는 경우 - 대기 아이콘 이 0.5초? 떴다가 동영상 이 재생됨

    유튜브 의 경우를 보면 추정 이기는 한데
    video 초기화 -> play 사이에 약간의 시간 차이를 둬서 이를 해결 하는거 같음
   */
  void _initVideoPlayer() async {
    isOnVideoFinishedCalled = false;
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    // setState 를 선언 하는 이유 : play 가 안되 어도 video 의 첫번째 프레임 이 표시가 되도록 하기 위해서
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }

    _videoPlayerController.addListener(_onVideoChange);
    setState(() {
      _isMuted = kIsWeb;
    });
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
    // mounted : widget 이 mount 되었 는지 여부 반환
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }

    // 동영상 이 재생 되고 있는 상태 에서 화면이 보이지 않게 되면 재생 정지 처리
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _togglePlay();
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
        isScrollControlled: true,
        // bottom sheet child 가 scroll 이 가능한 widget 일때 true 로 설정
        context: context,
        builder: (context) => const VideoComments());

    // showModalBottomSheet 가 닫히면 await showModalBottomSheet 다음 로직이 실행 된다
    _togglePlay();
  }

  void _onVolumeTap() async {
    setState(() {
      _isMuted = !_isMuted;
    });

    if (_isMuted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(100);
    }
  }

  /*
     VisibilityDetector
     widget 이 이동시 이전-현재 widget 이 이동한 정도를 체크 하는 API
   */
  @override
  Widget build(BuildContext context) {
    final videoConfig = VideoConfigData.of(context);
    debugPrint("videoConfig : ${videoConfig.autoMute}");

    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(
                    _videoPlayerController,
                    key: Key(
                      "${widget.index}",
                    ),
                  )
                : Container(color: Colors.black),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePlay,
            ),
          ),
          AnimatedVideoButton(
            animationController: _animationController,
            isPaused: _isPaused,
            animationDuration: _animationDuration,
          ),
          Positioned(
            top: 25,
            left: 10,
            child: GestureDetector(
              onTap: _onVolumeTap,
              child: VideoConfigData.of(context).autoMute
                  ? const FaIcon(
                      FontAwesomeIcons.volumeOff,
                      color: Colors.white,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.volumeHigh,
                      color: Colors.white,
                    ),
            ),
          ),
          const VideoPostBottomArea(
            loginUser: "@로그인한 사람",
            description: "aaabbbcccdddddddd",
            tag:
                "#123, #3333333, #55555555, #444444444444, #444444444444, #444444444444",
          ),
          VideoPostRightArea(commentFunction: _onTapComment),
        ],
      ),
    );
  }
}
