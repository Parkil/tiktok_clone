import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/util/utils.dart';

class ProfileAppBar extends StatelessWidget {
  final String userName;

  const ProfileAppBar({
    super.key,
    required this.userName,
  });

  void _onSettingTap(BuildContext context) {
    context.goNamed(SettingsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: isDarkMode(context) ? Colors.black : null,
      title: Text(userName),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _onSettingTap(context),
          icon: const FaIcon(
            FontAwesomeIcons.gear,
            size: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
