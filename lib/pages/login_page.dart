import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picto_flutter_chat/components/confirmation_button.dart';
import 'package:picto_flutter_chat/components/login_with_buttons.dart';
import 'package:picto_flutter_chat/components/menu_app_bar.dart';
import 'package:picto_flutter_chat/components/menu_bottom_nav_bar.dart';
import '../components/account_text_bar.dart';
import '../components/horizontal_lines_background_painter.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

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
                bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 80.0 : 0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 50.0,
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
                            labelText: "Username or Email",
                            obscureText: false,
                            controller: widget._usernameController,
                          ),
                          AccountTextBar(
                            labelText: "Password",
                            obscureText: true,
                            controller: widget._passwordController,
                          ),
                          ConfirmationButton(buttonText: "Log in"),
                        ],
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
                                imagePath: "assets/logo/google_pixel_logo.png",
                                backgroundColor: Color(0xFFd9d9d9),
                              ),
                              LoginWithButtons(
                                buttonText: "Discord",
                                redirectPage: Placeholder(),
                                imagePath: "assets/logo/discord_pixel_logo.png",
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
              child: MenuBottomNavBar(buttonText: "Sign Up"),
            ),
        ],
      ),
    );
  }
}
