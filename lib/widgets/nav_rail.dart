import 'package:flutter/material.dart';
import 'nav_content.dart';

class NavRail extends StatelessWidget {
  final String currentRouteName;
  const NavRail({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: NavContent(currentRouteName: currentRouteName),
    );
  }
}