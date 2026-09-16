import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/chat_room_button.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/menu_bottom_nav_bar.dart';
import 'package:picto_flutter_chat/models/server_model.dart';
import 'package:picto_flutter_chat/pages/chat_page.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';

import '../components/horizontal_lines_background_painter.dart';
import '../components/menu_app_bar.dart';
import '../utils/server_list_handler.dart';

class ServerChoicePage extends StatefulWidget {
  const ServerChoicePage({super.key});

  @override
  State<ServerChoicePage> createState() => _ServerChoicePageState();
}

class _ServerChoicePageState extends State<ServerChoicePage> {
  late Future<List<ServerModel>> serverList;

  Future<void> getServerList() async {
    serverList = ServerListHandler().getServerList();
  }

  Future<void> refreshServers() async {
    setState(() {
      serverList = ServerListHandler().getServerList();
    });

    try {
      await serverList;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to refresh servers')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getServerList();
  }

  void logout() async {
    try {
      await authService.value.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
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
              child: RefreshIndicator(
                onRefresh: refreshServers,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: FutureBuilder<List<ServerModel>>(
                      future: serverList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (snapshot.hasError) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'Unable to load servers.',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "Nintendo_DS_Bios",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Text(
                                  'Please check your network connection or try again.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontFamily: "Pixelify",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ConfirmationButton(
                                action: () async {
                                  await refreshServers();
                                },
                                buttonText: 'Retry',
                              ),
                            ],
                          );
                        }

                        final data = snapshot.data ?? [];
                        if (data.isEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'No servers available.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ConfirmationButton(
                                action: () async {
                                  await refreshServers();
                                },
                                buttonText: 'Retry',
                              ),
                            ],
                          );
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: data
                              .map(
                                (server) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: ChatRoomButton(
                                    chatRoomName: server.name,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                            serverModel: server,
                                          ),
                                        ),
                                      );
                                    },
                                    isOnline: server.online,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
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
