import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AnimatedVideoButton extends StatelessWidget {
  const AnimatedVideoButton({
    super.key,
    required AnimationController animationController,
    required bool isPaused,
    required animationDuration,
  })  : _animationController = animationController,
        _isPaused = isPaused,
        _animationDuration = animationDuration;

  final AnimationController _animationController;
  final bool _isPaused;
  final Duration _animationDuration;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      // IgnorePointer 해당 component 의 click 요소가 무시 된다 이경우 해당 영역을 클릭 하면 상위 widget 의 event 를 실행 하는듯
      child: IgnorePointer(
        child: Center(
          child: AnimatedBuilder(
            // builder ( = Animation 내용 )
            builder: (context, child) {
              // child == child: AnimatedOpacity
              // 해당 widget 의 scale 을 변경
              return Transform.scale(
                scale: _animationController.value,
                child: child,
              );
            },
            animation: _animationController,
            // child ( = Animation 을 수행할 대상 )
            child: AnimatedOpacity(
              opacity: _isPaused ? 1 : 0,
              duration: _animationDuration,
              child: const FaIcon(FontAwesomeIcons.play,
                  color: Colors.white, size: Sizes.size52),
            ),
          ),
        ),
      ),
    );
  }
}
