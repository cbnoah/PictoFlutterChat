import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/drawing_message.dart';
import 'package:picto_flutter_chat/components/message_page_app_bar.dart';
import 'package:picto_flutter_chat/components/text_message.dart';
import 'package:picto_flutter_chat/main.dart';

import '../components/color_builders.dart';

class ChatPage extends StatefulWidget {
  final int serverId;

  const ChatPage({super.key, required this.serverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textBarController = TextEditingController();
  List messages = [];

  Future<void> _getMessages() async {
    try {
      messages = await supabase
          .from("message")
          .select()
          .eq("id_server", widget.serverId);
      print("messages = ");
      print(messages);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      appBar: MessagePageAppBar(),
      backgroundColor: const Color(0xFFC0B9B7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                      TextMessage(messageContent: 'Message', username: 'Name'),
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
                    gradient: chatPageSeparatorGradient(),
                  ),
                ),
                // Typing area
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF5E5E5E)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: _textBarController,
                              decoration: InputDecoration(
                                hint: Text(
                                  "Message",
                                  style: TextStyle(
                                    fontFamily: "Nintendo_DS_BIOS",
                                    fontSize: 24.7,
                                    color: Color(0xFF0e155b),
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0e155b),
                                    width: 2.06,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.29),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0e155b),
                                    width: 2.06,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.29),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
