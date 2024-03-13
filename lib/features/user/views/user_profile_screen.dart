import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/enum/width_breakpoint.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_clone/features/user/views/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_appbar.dart';
import 'package:tiktok_clone/features/user/views/widgets/profile_info_area.dart';
import 'package:tiktok_clone/features/user/views/widgets/user_profile_grid.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String userName;
  final String tab;

  const UserProfileScreen(
      {super.key, required this.userName, required this.tab});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final double gridRatio = 9 / 13; // 가로 길이 / 세로 길이
  final double imageRatio = 9 / 13;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    WidthBreakPoint widthBreakPoint = WidthBreakPoint.findByWidth(width);

    return ref.watch(userProfileProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) {
            return SafeArea(
              child: DefaultTabController(
                length: 2,
                initialIndex: widget.tab == "likes" ? 1 : 0,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      ProfileAppBar(userName: widget.userName),
                      const ProfileInfoArea(),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: gridRatio,
                            // 1.0 (정사각형), 1.0 보다 크면 가로 길이가 길어 지고 작아 지면 세로 길이가 길어짐
                            crossAxisCount: widthBreakPoint.columnCount,
                            crossAxisSpacing: Sizes.size2,
                            //grid 세로 간격
                            mainAxisSpacing: Sizes.size2, // grid 가로 간격
                          ),
                          itemBuilder: (context, index) {
                            return const UserProfileGrid();
                          }),
                      const Center(
                        child: Text("Page Two"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
