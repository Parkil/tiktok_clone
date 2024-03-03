import 'package:flutter/material.dart';

class GridTextArea extends StatelessWidget {
  const GridTextArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "This is very long caption for my tiktok that i`,m  uploading just now currently",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w100,
          ),
    );
  }
}
