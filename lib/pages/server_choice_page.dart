import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/chat_room_button.dart';
import 'package:picto_flutter_chat/components/menu_bottom_nav_bar.dart';
import 'package:picto_flutter_chat/pages/chat_page.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';

import '../components/horizontal_lines_background_painter.dart';
import '../components/menu_app_bar.dart';

class ServerChoicePage extends StatefulWidget {
  const ServerChoicePage({super.key});

  @override
  State<ServerChoicePage> createState() => _ServerChoicePageState();
}

class _ServerChoicePageState extends State<ServerChoicePage> {
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBar(title: 'Choose a Chat Room to join'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          CustomPaint(
            painter: HorizontalLinesBackgroundPainter(
              spacing: 20,
              lineWidth: 1,
              lineColor: Color(0xFFcac4d0),
            ),
            size: Size.infinite,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 25,
                children: [
                  ChatRoomButton(
                    chatRoomName: "A",
                    messageCount: refactorMessageCount(12),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    ),
                  ),
                  ChatRoomButton(
                    chatRoomName: "B",
                    messageCount: refactorMessageCount(1051),
                  ),
                  ChatRoomButton(
                    chatRoomName: "C",
                    messageCount: refactorMessageCount(153),
                  ),
                  ChatRoomButton(
                    chatRoomName: "D",
                    messageCount: refactorMessageCount(12),
                  ),
                  //ElevatedButton(onPressed: logout, child: Text('Logout')),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuBottomNavBar(
        buttonText: "Settings",
        redirectPage: Scaffold(
          appBar: AppBar(title: Text("Settings")),
          body: Center(
            child: FilledButton(
              onPressed: () {
                logout();
                Navigator.pop(context);
              },
              child: Text("Log out"),
            ),
          ),
        ),
        icon: Icon(Icons.settings),
      ),
    );
  }
}
