import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/drawing_message.dart';
import 'package:picto_flutter_chat/components/message_page_app_bar.dart';
import 'package:picto_flutter_chat/components/text_message.dart';

import '../components/color_builders.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      appBar: MessagePageAppBar(),
      backgroundColor: const Color(0xFFC0B9B7),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Messages Area
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    TextMessage(messageContent: 'Message', username: 'Name',),
                    DrawingMessage(
                      imageLink:
                          "https://static.wikia.nocookie.net/silly-cat/images/3/35/CuhBG.png/revision/latest?cb=20231025181331",
                      username: 'Name',
                    ),
                  ],
                ),
              ),
              // Separator
              Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: chatPageSeparatorGradient()
                ),
              ),
              // Typing area
              const Column(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
