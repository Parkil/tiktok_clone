import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/views/widget/activity_list_area.dart';
import 'package:tiktok_clone/features/inbox/views/widget/activity_type_panel.dart';
import 'package:tiktok_clone/features/inbox/views/widget/dismissible_modal_barrier.dart';

class ActivityScreen extends StatefulWidget {
  static const routeUrl = "/activity";
  static const routeName = "activity";

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {

  // controller 에 여러 개의 animation 을 지정한 다음 관련된 animation 을 한번에 forward <-> reverse 처리 할수 있다
  late final AnimationController _animationController;

  // begin -> end 만큼 turn
  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  final List<Map<String, dynamic>> _typeList = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    },
  ];

  // Dismissible 에서 drag 를 해서 사라 졌다고 해서 실제 rendering 된 widget 이 제거가 되는 것이 아니기 때문에
  // re rendering 을 수행 해서 dismissed 된 widget 을 제거해 주어야 함
  // 공식 문서 에서도 setState 내부 에서 list element 를 삭제 하는 식으로 대응 하고 있음
  void _onDismissed(String key) {
    _notifications.remove(key);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronUp,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ActivityListArea(
            areaTitle: "New",
            data: _notifications,
            onDismissed: _onDismissed,
          ),
          DismissibleModalBarrier(
            animationController: _animationController,
            onDismiss: _toggleAnimations,
          ),
          ActivityTypePanel(
            animationController: _animationController,
            typeData: _typeList,
          ),
        ],
      ),
    );
  }
}
