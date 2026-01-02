import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/menu_app_bar.dart';
import 'package:picto_flutter_chat/components/menu_bottom_nav_bar.dart';
import 'package:picto_flutter_chat/utils/auth.dart';
import '../components/account_text_bar.dart';
import '../components/horizontal_lines_background_painter.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final _loginFormKey = GlobalKey<FormState>();
  String errorMessage = '';

  void register() async {
    if (widget._emailController.text == "" ||
        widget._passwordController.text == "") {
      setState(() {
        errorMessage = "Please fill all fields";
      });
      return;
    }
    try {
      await authService.value.registerWithEmailAndPassword(
        email: widget._emailController.text,
        password: widget._passwordController.text,
      );
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There\'s an error while registering';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: const MenuAppBar(title: 'Welcome to PictoFlutterChat'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 50.0,
                    children: [
                      Text(
                        'Create a new account',
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
                            labelText: "Username",
                            obscureText: false,
                            controller: widget._usernameController,
                            isPasswordField: false,
                          ),
                          AccountTextBar(
                            labelText: "Email",
                            obscureText: false,
                            controller: widget._emailController,
                            isPasswordField: false,
                          ),
                          AccountTextBar(
                            labelText: "Password",
                            obscureText: true,
                            controller: widget._passwordController,
                            isPasswordField: true,
                          ),
                          ConfirmationButton(
                            buttonText: "Sign in",
                            action: () => register(),
                          ),
                          Text(
                            errorMessage,
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
                redirectPage: LoginPage(),
                icon: Icon(Icons.account_circle_outlined)
              ),
            ),
        ],
      ),
    );
  }
}
