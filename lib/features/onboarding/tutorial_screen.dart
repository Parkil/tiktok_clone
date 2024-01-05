import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }
enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {

  Direction _direction = Direction.right;
  Page _page = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    Direction state = _direction;
    if(details.delta.dx > 0) { // to the right
      state = Direction.right;
    } else { // to the left
      state = Direction.left;
    }

    setState(() {
      _direction = state;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    Page state = _page;
    if (_direction == Direction.left) {
      state = Page.first;
    } else {
      state = Page.second;
    }

    setState(() {
      _page = state;
    });
  }

  void _onEnterAppTap() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainNavigationScreen()), (route) {
      return false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // 이건 1개의 widget 이고 이를 DefaultTabController 로 묶어서 처리를 해야 할듯
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v80,
                    Text("Watch cool videos",
                        style: TextStyle(
                            fontSize: Sizes.size40, fontWeight: FontWeight.bold)),
                    Gaps.v20,
                    Text("Videos are personalized for your based on what you watch, like, share",
                        style: TextStyle(
                            fontSize: Sizes.size20)),
                  ]),
              secondChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v80,
                    Text("Follow rules",
                        style: TextStyle(
                            fontSize: Sizes.size40, fontWeight: FontWeight.bold)),
                    Gaps.v20,
                    Text("Take care of one another",
                        style: TextStyle(
                            fontSize: Sizes.size20)),
                  ]),
              crossFadeState: _page == Page.first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size24, horizontal: Sizes.size24),
            child: AnimatedOpacity(
              opacity: _page == Page.first ?  0 : 1,
              duration: const Duration(milliseconds: 300),
              child: CupertinoButton(
                onPressed: _onEnterAppTap,
                color: Theme.of(context).primaryColor,
                child: const Text("Enter the app"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
