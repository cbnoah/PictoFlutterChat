import 'package:flutter/material.dart';

import 'bottom_nav_bar_button.dart';
import 'color_builders.dart';

class MenuBottomNavBar extends StatelessWidget {
  final String buttonText;
  final Widget redirectPage;
  final Icon? icon;

  const MenuBottomNavBar({
    super.key,
    required this.buttonText,
    required this.redirectPage, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: buildMenuAppBarAndBottomNavBarGradient(true),
        border: Border(top: BorderSide(color: Colors.black, width: 4)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SafeArea(
        child: BottomNavBarButton(
          buttonText: buttonText,
          redirectPage: redirectPage, icon: icon,
        ),
      ),
    );
  }
}
