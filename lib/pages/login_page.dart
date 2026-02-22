import 'dart:async';
import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/login_with_buttons.dart';
import 'package:picto_flutter_chat/components/menu_app_bar.dart';
import 'package:picto_flutter_chat/components/menu_bottom_nav_bar.dart';
import 'package:picto_flutter_chat/pages/reset_password.dart';
import 'package:picto_flutter_chat/pages/signup_page.dart';
import '../components/account_text_bar.dart';
import '../components/horizontal_lines_background_painter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  final authService = AuthService();
  String _errorMessage = '';

  void signIn() async {
    if (_emailController.text == "" || _passwordController.text == "") {
      setState(() {
        _errorMessage = "Please fill all fields";
      });
      return;
    }
    try {
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    } on AuthApiException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: const MenuAppBar(title: 'Welcome back'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
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
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom == 0
                    ? 80.0
                    : 0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20.0,
                    children: [
                      Text(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20.0,
                        children: [
                          AccountTextBar(
                            labelText: "Email",
                            obscureText: false,
                            controller: _emailController,
                            isPasswordField: false,
                          ),
                          AccountTextBar(
                            labelText: "Password",
                            obscureText: true,
                            controller: _passwordController,
                            isPasswordField: true,
                          ),
                          ConfirmationButton(
                            buttonText: "Log in",
                            action: () => signIn(),
                          ),
                        ],
                      ),
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "Pixelify",
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.8),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(
                                0,
                                2,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot your password ?",
                          style: TextStyle(
                            fontFamily: "Pixelify",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Text(
                            "Login with :",
                            style: TextStyle(
                              fontFamily: "Nintendo_DS_Bios",
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoginWithButtons(
                                buttonText: "Google",
                                redirectPage: Placeholder(),
                                imagePath: "assets/logos/google_pixel_logo.png",
                                backgroundColor: Color(0xFFd9d9d9),
                              ),
                              LoginWithButtons(
                                buttonText: "Discord",
                                redirectPage: Placeholder(),
                                imagePath:
                                    "assets/logos/discord_pixel_logo.png",
                                backgroundColor: Color(0xFF5662F6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: MenuBottomNavBar(
                buttonText: "Sign Up",
                redirectPage: SignupPage(),
                icon: Icon(Icons.add_circle_outline),
              ),
            ),
        ],
      ),
    );
  }
}
