import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/features/video/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/video/view_models/video_play_vn.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_comment/video_comments.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_play_button.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_post_bottom_area.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_post_right_area.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_volume_button.dart';
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

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _videoPlayerController;
  late bool isOnVideoFinishedCalled;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    context.read<PlayBackConfigVm>().addListener(_onPlayBackConfigChanged);
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
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);

    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }

    _videoPlayerController.addListener(_onVideoChange);
    // setState 를 선언 하는 이유 : play 가 안되 어도 video 의 첫번째 프레임 이 표시가 되도록 하기 위해서
    setState(() {});
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
    if (!mounted) return;
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      // watch 의 경우 widget tree 외부 에서 호출 하면 오류가 발생함
      bool autoplay = context.read<PlayBackConfigVm>().autoplay;
      if (autoplay) {
        _videoPlayerController.play();
      }
    }

    // 동영상 이 재생 되고 있는 상태 에서 화면이 보이지 않게 되면 재생 정지 처리
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _togglePlay();
    }
  }

  // video player 가 dispose -> init 되는 구조 이기 때문에 ValueNotifier 를 사용 해도 별 문제는 없을듯
  Future<void> _togglePlay() async {
    if (_videoPlayerController.value.isPlaying) {
      await _videoPlayerController.pause();
      videoPlayVn.value = false;
    } else {
      await _videoPlayerController.play();
      videoPlayVn.value = true;
    }
  }

  Future<void> _onTapComment(BuildContext context) async {
    if (!mounted) return;

    if (_videoPlayerController.value.isPlaying) {
      await _togglePlay();
    }

    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        // bottom sheet child 가 scroll 이 가능한 widget 일때 true 로 설정
        context: context,
        builder: (context) => const VideoComments());

    // showModalBottomSheet 가 닫히면 await showModalBottomSheet 다음 로직이 실행 된다
    await _togglePlay();
  }

  Future<void> _onPlayBackConfigChanged() async {
    final muted = context.read<PlayBackConfigVm>().muted;
    if (muted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(100);
    }
  }

  void _onVolumeTap() {
    bool currentValue = context.read<PlayBackConfigVm>().muted;
    context.read<PlayBackConfigVm>().setMuted(!currentValue);
  }

  /*
     VisibilityDetector
     widget 이 이동시 이전-현재 widget 이 이동한 정도를 체크 하는 API
   */
  @override
  Widget build(BuildContext context) {
    Key videoKey = Key("${widget.index}");

    return VisibilityDetector(
      key: videoKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(
                    _videoPlayerController,
                    key: videoKey,
                  )
                : Container(color: Colors.black),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePlay,
            ),
          ),
          VideoPlayButton(key: videoKey),
          Positioned(
            top: 25,
            left: 10,
            child: VideoVolumeButton(
              key: videoKey,
              onTap: _onVolumeTap,
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
