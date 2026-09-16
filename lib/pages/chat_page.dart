import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/drawing_message.dart';
import 'package:picto_flutter_chat/components/message_page_app_bar.dart';
import 'package:picto_flutter_chat/components/text_message.dart';
import 'package:picto_flutter_chat/models/message_model.dart';
import 'package:picto_flutter_chat/models/server_model.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';
import 'package:picto_flutter_chat/utils/message_getter.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_client;

import '../components/color_builders.dart';

class ChatPage extends StatefulWidget {
  final ServerModel serverModel;
  const ChatPage({super.key, required this.serverModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textBarController = TextEditingController();
  bool isLoading = true;
  bool textType = true;
  late List<MessageModel> messagesList;
  late final socket_client.Socket? socket;

  @override
  void initState() {
    super.initState();
    getServerList();
    socket = socket_client.io(
      'http://${widget.serverModel.ipAddress == "::1" ? "10.0.2.2" : widget.serverModel.ipAddress}:3003',
      socket_client.OptionBuilder().setTransports(['websocket']).build(),
    );

    setupListeners();
  }

  void setupListeners() {
    socket?.onConnect((_) {
      if (mounted) {
        setState(() {
          widget.serverModel.online = true;
        });
      }
      print('Connected to server');
    });

    socket?.onDisconnect((_) {
      if (mounted) {
        setState(() {
          widget.serverModel.online = false;
        });
      }
      print('Disconnected from server');
    });

    socket?.onError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to server')),
        );
        setState(() {
          widget.serverModel.online = false;
        });
      }
      print('Socket error: $error');
    });

    socket?.on('chat message', (msg) {
      if (msg == null) return;
      print('Raw socket message received: $msg');
      final msgData = (msg is Map && msg["newMessage"] != null)
          ? msg["newMessage"]
          : msg;
      if (msgData is! Map) return;
      if (msgData["content"] == null) return;

      print('Received message content: ${msgData["content"]}');
      if (mounted) {
        setState(() {
          messagesList.insert(
            0,
            MessageModel(
              content: msgData["content"] ?? "",
              createdAt: msgData["createdAt"] != null
                  ? DateTime.parse(msgData["createdAt"])
                  : DateTime.now(),
              id: msgData["id"] ?? "",
              messageType: MessageModel.stringToMessageType(
                msgData["messageType"] ?? "text",
              ),
              serverId: msgData["serverId"] ?? widget.serverModel.id,
              userId: msgData["userId"] ?? "",
              username:
                  msgData["username"] ??
                  (msgData["user"] is Map
                      ? msgData["user"]["username"]
                      : null) ??
                  "Unknown",
            ),
          );
        });
      }
    });
  }

  Future<void> getServerList() async {
    try {
      final messages = await MessageGetter().getMessages(widget.serverModel.id);
      if (mounted) {
        setState(() {
          messagesList = messages;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load messages')),
        );
      }
    }
  }

  void sendMessage() {
    final messageContent = _textBarController.text;
    final userId = authService.value.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not logged in, please log in again.'),
        ),
      );
      authService.value.signOut();
      return;
    }

    print('message content on controller : $messageContent');

    final Map<String, dynamic> messageData = {
      'userId': userId,
      'content': messageContent,
      'messageType': 'text',
    };

    if (messageContent.isNotEmpty) {
      socket?.emit('chat message', messageData);
      _textBarController.clear();
    }
  }

  @override
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      appBar: MessagePageAppBar(),
      backgroundColor: const Color(0xFFC0B9B7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Messages Area
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: isLoading
                    ? SizedBox(
                        height: 400,
                        child: Center(child: const CircularProgressIndicator()),
                      )
                    : messagesList.isEmpty
                    ? const Text("It's calm around here")
                    : SizedBox(
                        height: 400,
                        child: ListView.separated(
                          itemCount: messagesList.length,
                          clipBehavior: Clip.hardEdge,
                          reverse: true,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            final message = messagesList[index];
                            if (message.messageType == MessageType.text) {
                              return TextMessage(
                                messageContent: message.content,
                                username: message.username,
                              );
                            } else if (message.messageType ==
                                MessageType.image) {
                              return DrawingMessage(
                                imageLink: message.content,
                                username: message.username,
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
              ),
            ),
            // Separator
            Container(
              height: 40,
              decoration: BoxDecoration(gradient: chatPageSeparatorGradient()),
            ),
            // Typing area
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF5E5E5E)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        widget.serverModel.online ?
                        ConfirmationButton(
                          buttonText: "Send",
                          action: sendMessage,
                        ) : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF5E5E5E)),
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              "Offline",
                              style: TextStyle(
                                fontFamily: "Nintendo_DS_BIOS",
                                fontSize: 24.7,
                                color: Color(0xFF0e155b),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
