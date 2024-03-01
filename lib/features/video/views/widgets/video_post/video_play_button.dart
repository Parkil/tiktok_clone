import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/view_models/video_play_vn.dart';

class VideoPlayButton extends StatefulWidget {
  const VideoPlayButton({
    super.key,
  });

  @override
  State<VideoPlayButton> createState() => _VideoPlayButtonState();
}

class _VideoPlayButtonState extends State<VideoPlayButton>
    with TickerProviderStateMixin {
  late final AnimationController _playBtnAnimationController;

  // todo video config auto play 에서 값을 가져 오도록 수정
  bool _isPlay = true;

  get _playBtnAnimationDuration => const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    // lowerBound: animation 최소 크기, upperBound: animation 최대 크기, value: animation 기본값
    _playBtnAnimationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _playBtnAnimationDuration,
    );

    videoPlayVn.addListener(_playListener);
  }

  void _playListener() {
    if (!mounted) return;
    _isPlay = videoPlayVn.value;

    if (_isPlay) {
      _playBtnAnimationController.forward();
    } else {
      _playBtnAnimationController.reverse();
    }

    debugPrint("setStateCalled");
    setState(() {});
  }

  @override
  void dispose() {
    // _playBtnAnimationController.dispose();
    super.dispose();
  }

  /*
    AnimatedBuilder 안에 Transition 을 입력 하면 정상 적으로 작동 하지 않는듯 하다
   */
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      // IgnorePointer 해당 component 의 click 요소가 무시 된다 이경우 해당 영역을 클릭 하면 상위 widget 의 event 를 실행 하는듯
      child: IgnorePointer(
        child: Center(
          child: AnimatedBuilder(
            builder: (context, child) {
              // 해당 widget 의 scale 을 변경
              return Transform.scale(
                scale: _playBtnAnimationController.value,
                child: child,
              );
            },
            animation: _playBtnAnimationController,
            child: AnimatedOpacity(
              opacity: !_isPlay ? 1 : 0,
              duration: _playBtnAnimationDuration,
              child: const FaIcon(
                FontAwesomeIcons.play,
                color: Colors.white,
                size: Sizes.size52,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
