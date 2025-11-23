import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/color_builders.dart';

class ConfirmationButton extends StatelessWidget {
  final String buttonText;

  const ConfirmationButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: buildMenuButtonAndTextFieldsGradient()
      ),
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,

          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          textStyle: const TextStyle(
            fontFamily: "Pixelify",
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        child: const Text("Button"),
      ),
    );
  }
}
