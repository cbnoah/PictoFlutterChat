import 'package:flutter/material.dart';

import 'color_builders.dart';

class AccountTextBar extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool isPasswordField;
  final TextEditingController controller;

  const AccountTextBar({
    super.key,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    required this.isPasswordField,
  });

  @override
  State<AccountTextBar> createState() => _AccountTextBarState();
}

class _AccountTextBarState extends State<AccountTextBar> {
  late bool _obscureText = widget.obscureText;
  late final TextEditingController _controller = widget.controller;
  late final String _labelText = widget.labelText;
  late final bool _isPasswordField = widget.isPasswordField;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: buildMenuButtonAndTextFieldsGradient(),
        boxShadow: [menuButtonAndTextFieldBoxShadow()],
      ),
      child: TextFormField(
        obscureText: _obscureText,
        controller: _controller,
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
          labelText: _labelText,
          labelStyle: TextStyle(
            fontFamily: "Pixelify",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          suffixIcon: _isPasswordField ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: _obscureText
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          )
              : null,
        ),
      ),
    );
  }
}
