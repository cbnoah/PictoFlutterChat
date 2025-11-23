import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/menu_app_bar.dart';

import '../components/account_text_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppBar(title: 'Welcome back'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 50.0,
              children: [
                Text(
                  'Login to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Pixelify",
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 30.0,
                  children: [
                    AccountTextBar(labelText: "Username or Email"),
                    AccountTextBar(labelText: "Password"),
                    ConfirmationButton(buttonText: "Log in",)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
