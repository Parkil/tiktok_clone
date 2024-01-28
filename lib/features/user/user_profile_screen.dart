import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/user/widgets/custom_divider.dart';
import 'package:tiktok_clone/features/user/widgets/following_info.dart';
import 'package:tiktok_clone/features/user/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/features/user/widgets/user_profile_grid.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final double gridRatio = 9 / 13; // 가로 길이 / 세로 길이
  final double imageRatio = 9 / 13;

  CircleAvatar _userIcon() {
    return const CircleAvatar(
      radius: 50,
      foregroundImage: NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png",
      ),
      child: Text("사용자"),
    );
  }

  Row _userIdArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "@user_id",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.h8,
        FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          size: Sizes.size16,
          color: Colors.green.shade300,
        ),
      ],
    );
  }

  SizedBox _followingInfoArea() {
    return const SizedBox(
      height: Sizes.size52, // VerticalDivider 는 height 를 필요로 함
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FollowingInfo(count: "10M", label: "Followers"),
          CustomDivider(),
          FollowingInfo(count: "97", label: "Following"),
          CustomDivider(),
          FollowingInfo(count: "194.3M", label: "Likes"),
        ],
      ),
    );
  }

  Padding _userDescriptionArea() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size32,
      ),
      child: Text(
        "사용자와 관련된 설명, ㄹㅇ나ㅣ;ㅓㅣㅏㅇ넘라ㅣㅇㄴ머리ㅏㅇㅁ너라ㅣㅇㄴ무리ㅏㅇㄴ무라ㅓㅇ누라ㅓㅇㄴ",
        textAlign: TextAlign.center,
      ),
    );
  }

  Row _userPageLinkArea() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(FontAwesomeIcons.link, size: Sizes.size14),
        Gaps.h4,
        Text(
          "http://user_info.com/test_page",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // todo _buttonArea 를 flexible 로 처리 하는 방법 강구
  SizedBox _buttonArea() {
    return SizedBox(
      height: Sizes.size48,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size64,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.size4),
              ),
            ),
            child: const Text(
              "Follow",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gaps.h8,
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
              ),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.shade300, width: Sizes.size1),
                color: Colors.white,
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.youtube),
              )),
          Gaps.h8,
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.shade300, width: Sizes.size1),
                color: Colors.white,
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.angleDown),
              )),
        ],
      ),
    );
  }

  void _onSettingTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("사용자"),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: _onSettingTap,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _userIcon(),
                    Gaps.v20,
                    _userIdArea(),
                    Gaps.v24,
                    _followingInfoArea(),
                    Gaps.v14,
                    _buttonArea(),
                    Gaps.v14,
                    _userDescriptionArea(),
                    Gaps.v14,
                    _userPageLinkArea(),
                  ],
                ),
              ),
              //Sliver ~ widget 은 다른 Sliver widget 의 child 가 될수 없음
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                itemCount: 20,
                padding: EdgeInsets.zero,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // 드래그 를 수행 하면 키보드 가 사라짐
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: gridRatio,
                  // 1.0 (정사각형), 1.0 보다 크면 가로 길이가 길어 지고 작아 지면 세로 길이가 길어짐
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  //grid 세로 간격
                  mainAxisSpacing: Sizes.size2, // grid 가로 간격
                ),
                itemBuilder: (context, index) {
                  return const UserProfileGrid();
                }
              ),
              const Center(
                child: Text("Page Two"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
