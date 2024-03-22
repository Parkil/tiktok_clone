import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/utils.dart';

class ActivityTypePanel extends StatefulWidget {
  final AnimationController animationController;
  final List<Map<String, dynamic>> typeData;

  const ActivityTypePanel({
    super.key,
    required this.animationController,
    required this.typeData,
  });

  @override
  State<ActivityTypePanel> createState() => _ActivityTypePanelState();
}

class _ActivityTypePanelState extends State<ActivityTypePanel> {

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1), // x, y
    end: const Offset(0, 0), // x, y
  ).animate(widget.animationController);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _panelAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode(context) ? Theme.of(context).appBarTheme.backgroundColor : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Sizes.size4),
            bottomRight: Radius.circular(Sizes.size4),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var type in widget.typeData)
              ListTile(
                leading: Icon(
                  type['icon'],
                  size: Sizes.size16,
                ),
                title: Text(
                  type['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
