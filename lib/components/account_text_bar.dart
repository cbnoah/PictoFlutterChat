import 'package:flutter/material.dart';

import 'color_builders.dart';

class AccountTextBar extends StatelessWidget {
  final String labelText;


  const AccountTextBar({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: buildMenuButtonAndTextFieldsGradient(),
        boxShadow: [menuButtonAndTextFieldBoxShadow()],
      ),
      child: TextField(
        style: TextStyle(
          fontFamily: "Pixelify",
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFA4A4A4), width: 2),
            borderRadius: BorderRadius.circular(0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF507e94), width: 2),
            borderRadius: BorderRadius.circular(0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: "Pixelify",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
