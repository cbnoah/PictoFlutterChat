import 'package:flutter/material.dart';

import 'color_builders.dart';

class LoginWithButtons extends StatelessWidget {
  final String buttonText;
  final Widget redirectPage;
  final String imagePath;
  final Color backgroundColor;

  const LoginWithButtons({
    super.key,
    required this.buttonText,
    required this.redirectPage,
    required this.imagePath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => redirectPage),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: buildMenuButtonAndTextFieldsGradient(),
          border: Border.all(color: Color(0xFFA4A4A4), width: 2),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xFF7c7c7c)),
                color: backgroundColor,
              ),
              child: Image.asset(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: "Nintendo_DS_Bios",
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
