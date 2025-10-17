import 'package:flutter/material.dart';
import 'nav_content.dart';

class NavDrawer extends StatelessWidget {
  final String currentRouteName;
  const NavDrawer({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NavContent(currentRouteName: currentRouteName),
    );
  }
}