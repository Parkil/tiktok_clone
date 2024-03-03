import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/enum/width_breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/widgets/grid_bottom_area.dart';
import 'package:tiktok_clone/features/discover/widgets/grid_image_area.dart';
import 'package:tiktok_clone/features/discover/widgets/grid_text_area.dart';
import 'package:tiktok_clone/features/discover/widgets/search_text_field.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  // 가로 길이 / 세로 길이
  final double gridRatio = 9 / 20;

  void _onSearchChanged(String value) {
    debugPrint("input value : $value");
  }

  void _onSearchSubmitted(String value) {
    debugPrint("submit value : $value");
  }

  void _closeSearchKeyboard(int tabIndex) {
    FocusScope.of(context).unfocus();
  }

  bool _isBottomShowing(BoxConstraints constraints) {
    return constraints.maxWidth < 200 || constraints.maxWidth > 250;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    WidthBreakPoint widthBreakPoint = WidthBreakPoint.findByWidth(width);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: ConstrainedBox( // widget 의 길이를 제한
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: SearchTextField(
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          centerTitle: true,
        bottom: TabBar( // PreferredSizeWidget 의 경우 PreferredSize 를 계산 하는 로직이 들어 가야 하기 때문에 별로 widget 으로 빼지 않음
            onTap: _closeSearchKeyboard,
            splashFactory: NoSplash.splashFactory,
            tabAlignment: TabAlignment.center,
            // 미 지정시 처음탭 옆에 빈 공간이 생긴것 처럼 rendering 된다
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // 드래그 를 수행 하면 키보드 가 사라짐
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: gridRatio,
                // 1.0 (정 사각형), 1.0 보다 크면 가로 길이가 길어 지고 작아 지면 세로 길이가 길어짐
                crossAxisCount: widthBreakPoint.columnCount,
                crossAxisSpacing: Sizes.size10,
                //grid 세로 간격
                mainAxisSpacing: Sizes.size10, // grid 가로 간격
              ),

              /*
                MediaQuery.of(context).size - 전체 화면의 size
                LayoutBuilder constraints - 현재 widget 의 size

                만약 layoutBuilder 를 전체 화면의 body 에 설정 하는 경우 에는 2개가 동일 하게 표시 될 수 있다
               */
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      const GridImageArea(),
                      Gaps.v10,
                      const GridTextArea(),
                      Gaps.v8,
                      if (_isBottomShowing(constraints)) const GridBottomArea()
                    ],
                  );
                },
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
