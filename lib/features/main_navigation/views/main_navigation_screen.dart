import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/views/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/view_models/tab_name_vn.dart';
import 'package:tiktok_clone/features/main_navigation/views/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/views/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/user/views/user_profile_screen.dart';
import 'package:tiktok_clone/features/video/views/video_recording_screen.dart';
import 'package:tiktok_clone/features/video/views/video_timeline_screen.dart';
import 'package:tiktok_clone/util/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeUrl = "/:tab(home|discover|inbox|profile)";
  static const routeName = "main";

  final String tabName;

  const MainNavigationScreen({
    super.key,
    required this.tabName,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void _goOffStage(String tabName) {
    context.go("/$tabName");
  }

  void _onPostVideoTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  /*
  state 가 초기화 되어야 되는 경우 : 단순 정보성 페이지, 입력 값을 받는 페이지(특히 입력 값에 대해서 특정 상태가 변경 되는 경우)
  state 가 초기화 되지 않아야 하는 경우 : 데이터 조회 페이지
   */
  @override
  Widget build(BuildContext context) {
    tabNameVn.value = widget.tabName;

    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 표시시 화면 조정을 하지 않도록 설정
      body: Stack(
        children: [
          Offstage(
            offstage: widget.tabName != 'home',
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: widget.tabName != 'discover',
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: widget.tabName != 'inbox',
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: widget.tabName != 'profile',
            child: const UserProfileScreen(userName: '사용자', tab: 'show'),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: switchColor(
            condition: checkNavTabDarkMode(context, widget.tabName),
            matchedColor: Colors.black,
            altColor: Colors.white),
        surfaceTintColor: switchColor(
            condition: checkNavTabDarkMode(context, widget.tabName),
            matchedColor: Colors.black,
            altColor: Colors.white),
        height: 73,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              selectedIcon: FontAwesomeIcons.house,
              nonSelectedIcon: FontAwesomeIcons.house,
              tabText: 'Home',
              tabName: 'home',
              onTab: () => _goOffStage('home'),
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidCompass,
              nonSelectedIcon: FontAwesomeIcons.compass,
              tabText: 'Discover',
              tabName: 'discover',
              onTab: () => _goOffStage('discover'),
            ),
            Gaps.h24,
            PostVideoButton(
              onTap: _onPostVideoTap,
            ),
            Gaps.h24,
            NavTab(
              selectedIcon: FontAwesomeIcons.solidMessage,
              nonSelectedIcon: FontAwesomeIcons.message,
              tabText: 'InBox',
              tabName: 'inbox',
              onTab: () => _goOffStage('inbox'),
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidUser,
              nonSelectedIcon: FontAwesomeIcons.user,
              tabText: 'Profile',
              tabName: 'profile',
              onTab: () => _goOffStage('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
