import 'package:flutter/material.dart';

Gradient buildMenuButtonAndTextFieldsGradient() {
  return const LinearGradient(
    colors: [Colors.white, Color(0xFFA8A8A8)],
    stops: [0.0, 0.88],
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
