import 'package:flutter/material.dart';

import 'color_builders.dart';

class BottomNavBarButton extends StatelessWidget {
  final String buttonText;
  final Widget redirectPage;
  final Icon? icon;

  const BottomNavBarButton({
    super.key,
    required this.buttonText,
    required this.redirectPage, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => redirectPage,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: Container(
                  color: Colors.white,
                  child: child,
                ),
              );
            },
          ),
        );

      },
      child: Container(
        decoration: BoxDecoration(
          gradient: buildMenuButtonAndTextFieldsGradient(),
          border: Border.all(color: Color(0xFFA4A4A4), width: 2),
        ),
        margin: EdgeInsets.symmetric(horizontal: 100),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ?icon,
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
