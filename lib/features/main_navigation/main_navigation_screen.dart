import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/video/video_timeline_screen.dart';
import 'package:tiktok_clone/util/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeUrl = "/";
  static const routeName = "main";

  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _goOffStage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPostVideoTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container(), fullscreenDialog: true));
  }

  /*
  state 가 초기화 되어야 되는 경우 : 단순 정보성 페이지, 입력 값을 받는 페이지(특히 입력 값에 대해서 특정 상태가 변경 되는 경우)
  state 가 초기화 되지 않아야 하는 경우 : 데이터 조회 페이지
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 표시시 화면 조정을 하지 않도록 설정
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(userName: '사용자', tab: 'show'),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: switchColor(
            condition: isNavTabDarkMode(context, _selectedIndex),
            matchedColor: Colors.black,
            altColor: Colors.white),
        surfaceTintColor: switchColor(
            condition: isNavTabDarkMode(context, _selectedIndex),
            matchedColor: Colors.black,
            altColor: Colors.white),
        height: 73,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              selectedIcon: FontAwesomeIcons.house,
              nonSelectedIcon: FontAwesomeIcons.house,
              text: "Home",
              isSelected: _selectedIndex == 0,
              onTab: () => _goOffStage(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidCompass,
              nonSelectedIcon: FontAwesomeIcons.compass,
              text: "Discover",
              isSelected: _selectedIndex == 1,
              onTab: () => _goOffStage(1),
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            PostVideoButton(
              onTap: _onPostVideoTap,
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            NavTab(
              selectedIcon: FontAwesomeIcons.solidMessage,
              nonSelectedIcon: FontAwesomeIcons.message,
              text: "InBox",
              isSelected: _selectedIndex == 3,
              onTab: () => _goOffStage(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidUser,
              nonSelectedIcon: FontAwesomeIcons.user,
              text: "Profile",
              isSelected: _selectedIndex == 4,
              onTab: () => _goOffStage(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
