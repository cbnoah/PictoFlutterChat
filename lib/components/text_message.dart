import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final String messageContent;
  final String username;

  const TextMessage({super.key, required this.messageContent, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFb7baef),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.29)
            ),
            border: Border(
              left: BorderSide(color: Color(0xFF0e155b), width: 2),
              right: BorderSide(color: Color(0xFF0e155b), width: 2),
              top: BorderSide(color: Color(0xFF0e155b), width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Name",
              style: TextStyle(
                fontFamily: "Nintendo_DS_BIOS",
                fontSize: 24.7,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.06),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.29)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
            child: Text(
              'Message',
              style: TextStyle(
                fontFamily: "Nintendo_DS_BIOS",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
