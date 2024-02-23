import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const routeUrl = "/chat";
  static const routeName = "chat";

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  Widget _listBuilder(
      BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      key: UniqueKey(),
      child: ScaleTransition(
        scale: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: _listTile(index),
        ),
      ),
    );
  }

  ListTile _listTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        foregroundImage: NetworkImage(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png",
        ),
        child: Text("사용자"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "사용자 ($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              fontSize: Sizes.size16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        "안녕하세요",
      ),
    );
  }

  final Duration _duration = const Duration(milliseconds: 300);
  int listSize = 0;

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => Container(
          color: Colors.red,
          child: SizeTransition(
            sizeFactor: animation,
            child: _listTile(index),
          ),
        ),
        duration: _duration,
      );

      listSize--;
    }
  }

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        listSize,
        duration: _duration,
      );

      listSize++;
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(ChatDetailScreen.routeName, pathParameters: {"id": "$index"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct messages"),
        centerTitle: true,
        elevation: 0.5,
        shadowColor: Colors.grey,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
            ),
            onPressed: _addItem,
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: _listBuilder,
      ),
    );
  }
}
