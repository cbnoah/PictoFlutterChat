import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/utils/auth.dart';

class ServerChoicePage extends StatefulWidget {
  const ServerChoicePage({super.key});

  @override
  State<ServerChoicePage> createState() => _ServerChoicePageState();
}

class _ServerChoicePageState extends State<ServerChoicePage> {
  void logout() async {
    try {
      await authService.value.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(onPressed: () => logout(), child: Text("Log out")),
      ),
    );
  }
}
