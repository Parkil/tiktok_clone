import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/enum/width_breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
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

  final double gridRatio = 9 / 20;

  // 가로 길이 / 세로 길이
  final double imageRatio = 9 / 16;

  void _onSearchChanged(String value) {
    debugPrint("input value : $value");
  }

  void _onSearchSubmitted(String value) {
    debugPrint("submit value : $value");
  }

  void _closeSearchKeyboard(int tabIndex) {
    FocusScope.of(context).unfocus();
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
    debugPrint("width: $width / enum check: $widthBreakPoint");

    return DefaultTabController(
      length: tabs.length,
      // length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          // title: CupertinoSearchTextField(),
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
          bottom: TabBar(
            onTap: _closeSearchKeyboard,
            splashFactory: NoSplash.splashFactory,
            tabAlignment: TabAlignment.center,
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // 드래그 를 수행 하면 키보드 가 사라짐
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: gridRatio,
                // 1.0 (정사각형), 1.0 보다 크면 가로 길이가 길어 지고 작아 지면 세로 길이가 길어짐
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
                      Container(
                        /*
                        밑에서 설정한 borderRadius 가 image 에 가려 지는 현상을 방지 하기 위해서 clipBehavior 를 설정
                       */
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
                          aspectRatio: imageRatio,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/image_0009.png',
                            // image 가 로딩 되기 전에 표시할 이미지
                            image:
                                'https://images.unsplash.com/photo-1704739308671-96dd994617d8?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        "This is very long caption for my tiktok that i`,m  uploading just now currently",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Gaps.v8,
                      if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  "My avatar is very long text",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size16,
                                color: Colors.grey.shade600,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.5M",
                              ),
                            ],
                          ),
                        ),
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
