import 'package:flutter/material.dart';

class CameraIcon extends StatelessWidget {
  final bool isSelected;
  final Widget icon;
  final Function onPress;

  const CameraIcon({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelected ? Colors.amber : Colors.white,
      onPressed: () => onPress(),
      icon: icon,
    );
  }
}
