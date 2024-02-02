import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/util/utils.dart';

import 'widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {

  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset >= 110 && _showTitle == true) {
      return;
    }

    setState(() {
      _showTitle = _scrollController.offset >= 110;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNextTab() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TutorialScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
            opacity: _showTitle ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Text("Choose Your interests")),
        centerTitle: true,
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text("Choose Your interests",
                    style: TextStyle(
                        fontSize: Sizes.size40, fontWeight: FontWeight.bold)),
                Gaps.v20,
                const Text("Get better video recommendations",
                    style: TextStyle(fontSize: Sizes.size20)),
                Gaps.v64,
                Wrap(
                  runSpacing: 15, // 각 component 간 세로 간격
                  spacing: 15, // 각 component 간 가로 간격
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest)
                ],)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 150, //material theme 에서는 height 가 없을 경우 80으로 고정 그외 theme 에서는 안의 contents 에 맞게 조정
        surfaceTintColor: Colors.white,
        color: isDarkMode(context) ? null : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: Sizes.size40, top: Sizes.size16, left: Sizes.size24, right: Sizes.size24),
          child: GestureDetector(
            child: CupertinoButton(
              onPressed: _onNextTab,
              color: Theme.of(context).primaryColor,
              child: const Text("Next"),
            ),
          )
        ),
      ),
    );
  }
}
