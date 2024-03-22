import 'package:flutter/material.dart';

class DismissibleModalBarrier extends StatefulWidget {
  final AnimationController animationController;
  final Function onDismiss;

  const DismissibleModalBarrier({
    super.key,
    required this.animationController,
    required this.onDismiss,
  });

  @override
  State<DismissibleModalBarrier> createState() =>
      _DismissibleModalBarrierState();
}

class _DismissibleModalBarrierState extends State<DismissibleModalBarrier> {
  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(widget.animationController);

  @override
  Widget build(BuildContext context) {
    // setState 를 여기로 가져 와야 하지 않을까?
    return widget.animationController.status == AnimationStatus.dismissed
        ? const SizedBox.shrink()
        : _buildBarrier();
  }

  AnimatedModalBarrier _buildBarrier() {
    return AnimatedModalBarrier(
      color: _barrierAnimation,
      dismissible: true,
      onDismiss: () => widget.onDismiss(),
    );
  }
}
