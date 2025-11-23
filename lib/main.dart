import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/pages/login_page.dart';
import 'package:picto_flutter_chat/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: LoginPage(),
    );
  }
}
