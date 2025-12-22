import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/utils/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  String errorMessage = '';

  void resetPassword() async {
    try {
      await authService.value.resetPassword(email: _emailController.text);
      setState(() {
        errorMessage = '';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage =
            e.message ?? 'An error occurred while resetting password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
