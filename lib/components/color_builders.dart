import 'package:flutter/material.dart';

Gradient buildMenuButtonAndTextFieldsGradient() {
  return const LinearGradient(
    colors: [Colors.white, Color(0xFFA8A8A8)],
    stops: [0.0, 0.88],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Gradient buildMenuAppBarAndBottomNavBarGradient(bool inverted) {
  if (inverted) {
    return const LinearGradient(
      colors: [Color(0xFF507e94), Color(0xFF94abb7), Color(0xFFd9d9d9)],
      stops: [0.0, 0.27, 0.76],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  return const LinearGradient(
    colors: [Color(0xFFd9d9d9), Color(0xFF94abb7), Color(0xFF507e94)],
    stops: [0.0, 0.27, 0.76],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

BoxShadow menuButtonAndTextFieldBoxShadow() {
  return BoxShadow(
    color: Colors.black.withValues(alpha: 0.8),
    spreadRadius: 1,
    blurRadius: 4,
    offset: const Offset(0, 4), // changes position of shadow
  );
}
