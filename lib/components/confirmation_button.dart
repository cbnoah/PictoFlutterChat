import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/color_builders.dart';

class ConfirmationButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback action;

  const ConfirmationButton({super.key, required this.buttonText, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: buildMenuButtonAndTextFieldsGradient(),
        border: Border.all(color: Color(0xFFA4A4A4), width: 2),
        boxShadow: [menuButtonAndTextFieldBoxShadow()],
      ),
      child: TextButton(
        onPressed: action,
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(0),
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: const TextStyle(
            fontFamily: "Nintendo_DS_Bios",
            fontSize: 30,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
