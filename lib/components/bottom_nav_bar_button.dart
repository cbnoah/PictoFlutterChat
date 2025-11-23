import 'package:flutter/material.dart';

import 'color_builders.dart';

class BottomNavBarButton extends StatelessWidget {
  final String buttonText;

  const BottomNavBarButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Define the action to be performed on tap
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: buildMenuButtonAndTextFieldsGradient(),
          border: Border.all(color: Color(0xFFA4A4A4), width: 2),
        ),
        margin: EdgeInsets.symmetric(horizontal: 120),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.add_circle_outline),
              Text(
                buttonText,
                style: TextStyle(
                  fontFamily: "Nintendo_DS_Bios",
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
