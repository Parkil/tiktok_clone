import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/video/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
  material v2 - google 에서 만든 오픈 소스 디자인 프레임 워크
  BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    onTap: _onTap,
    currentIndex: _selectedIndex,
    // selectedItemColor: Theme.of(context).primaryColor,

    // item 이 4개 이상일 경우 item 클릭 시 background color animation 이 활성화 된다
    items: [
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home", tooltip: "What are you?", backgroundColor: Colors.amber),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search", tooltip: "What are you?", backgroundColor: Colors.blue),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home1", tooltip: "What are you?", backgroundColor: Colors.pink),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search1", tooltip: "What are you?",  backgroundColor: Colors.yellow),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search1", tooltip: "What are you?", backgroundColor: Colors.teal)
    ],
  )
   */

  /*
  cupertino - IOS 기반 의 theme
  CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.house, color: Colors.teal), label: "Home"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.search, color: Colors.teal), label: "Search"),
          ],
        ),
        tabBuilder: (context, index) => screens[index])
   */

  /*
    material v3
    Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.house, color: Colors.teal), label: "Home", tooltip: "What are you?"),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.amber), label: "Search", tooltip: "What are you?"),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.house), label: "Home1", tooltip: "What are you?"),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search1", tooltip: "What are you?"),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search1", tooltip: "What are you?")
        ],
      ),
    )
   */

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
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 0 ? Colors.black : Colors.white,
        height: 73,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              selectedIcon: FontAwesomeIcons.house,
              nonSelectedIcon: FontAwesomeIcons.house,
              text: "Home",
              isSelected: _selectedIndex == 0,
              onTab: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidCompass,
              nonSelectedIcon: FontAwesomeIcons.compass,
              text: "Discover",
              isSelected: _selectedIndex == 1,
              onTab: () => _onTap(1),
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
              onTab: () => _onTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidUser,
              nonSelectedIcon: FontAwesomeIcons.user,
              text: "Profile",
              isSelected: _selectedIndex == 4,
              onTab: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
