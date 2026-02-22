import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/color_builders.dart';

String refactorMessageCount(int messageCount) {
  var messageCountString = messageCount.toString();
  switch (messageCount) {
    case < 100:
      return "0$messageCountString";
    case > 999:
      return "999+";
    default:
      return messageCountString;
  }
}

class ChatRoomButton extends StatelessWidget {
  final String chatRoomName;
  final VoidCallback? onTap;
  final String messageCount;

  const ChatRoomButton({
    super.key,
    required this.chatRoomName,
    this.onTap,
    required this.messageCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: buildMenuButtonAndTextFieldsGradient(),
          boxShadow: [menuButtonAndTextFieldBoxShadow()],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              width: 70,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xFF7c7c7c)),
              ),
              clipBehavior: Clip.none,
              child: OverflowBox(
                maxWidth: 200,
                maxHeight: 200,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        chatRoomName,
                        style: TextStyle(
                          fontFamily: "Nintendo_DS_Bios",
                          fontSize: 100,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Color(0xFF717171),
                        ),
                      ),
                      Text(
                        chatRoomName,
                        style: TextStyle(
                          fontFamily: "Nintendo_DS_Bios",
                          fontSize: 100,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Chat Room $chatRoomName",
              style: TextStyle(fontFamily: "Nintendo_DS_Bios", fontSize: 35),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF797979), width: 2),
              ),
              child: Row(
                spacing: 4,
                children: [
                  Image.asset('assets/icons/message_icon.png'),
                  Text(
                    messageCount,
                    style: TextStyle(
                      fontFamily: "Nintendo_DS_Bios",
                      fontSize: 35,
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
