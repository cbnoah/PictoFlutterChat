import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/menu_app_bar.dart';
import '../components/account_text_bar.dart';
import '../components/horizontal_lines_background_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBar(title: 'Welcome back'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: HorizontalLinesBackgroundPainter(
                spacing: 20,
                lineWidth: 1,
                lineColor: Color(0xFFcac4d0),
              ),
              size: Size.infinite,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50.0,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Login to your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nintendo_DS_Bios",
                          fontWeight: FontWeight.w700,
                          fontSize: 55,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 30.0,
                      children: [
                        AccountTextBar(labelText: "Username or Email"),
                        AccountTextBar(labelText: "Password"),
                        ConfirmationButton(buttonText: "Log in"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
