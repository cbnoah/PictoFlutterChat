import 'package:flutter/material.dart';

import '../components/account_text_bar.dart';
import '../components/color_builders.dart';
import '../components/confirmation_button.dart';
import '../components/horizontal_lines_background_painter.dart';
import '../components/menu_app_bar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  String errorMessage = '';

  void resetPassword() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBar(title: 'Forgot your password ?'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          CustomPaint(
            painter: HorizontalLinesBackgroundPainter(
              spacing: 20,
              lineWidth: 1,
              lineColor: const Color(0xFFcac4d0),
            ),
            size: Size.infinite,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom == 0
                    ? 80.0
                    : 0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20.0,
                  children: [
                    Text(
                      'Enter your email to reset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Nintendo_DS_Bios",
                        fontWeight: FontWeight.w700,
                        fontSize: 55,
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    AccountTextBar(
                      controller: _emailController,
                      labelText: 'Email',
                      obscureText: false,
                      isPasswordField: false,
                    ),
                    ConfirmationButton(
                      buttonText: "Send reset link",
                      action: () => resetPassword(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: buildMenuAppBarAndBottomNavBarGradient(true),
          border: Border(top: BorderSide(color: Colors.black, width: 4)),
        ),
      ),
    );
  }
}
