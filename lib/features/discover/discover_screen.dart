import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  static final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("Discover"),
          centerTitle: true,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            tabAlignment: TabAlignment.start,
            // 미 지정시 처음탭 옆에 빈 공간이 생긴것 처럼 rendering 된다
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10, //grid 세로 간격
                mainAxisSpacing: Sizes.size10, // grid 가로 간격
                childAspectRatio: 9 / 16, // 1.0 (정사각형), 1.0 보다 크면 가로 길이가 길어 지고 작아 지면 세로 길이가 길어짐
              ),
              itemBuilder: (context, index) => Container(
                color: Colors.teal,
                child: Center(
                  child: Text("$index"),
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: Sizes.size28),
                ),
              )
          ],
        ),
      ),
    );
  }
}
