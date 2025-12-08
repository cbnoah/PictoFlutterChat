import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MenuAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFd9d9d9), Color(0xFF94abb7), Color(0xFF507e94)],
          stops: [0.0, 0.27, 0.76],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(bottom: BorderSide(color: Colors.black, width: 4)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontFamily: "Nintendo_DS_Bios", fontSize: 35, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}
