import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/pages/app_loading_page.dart';
import 'package:picto_flutter_chat/pages/login_page.dart';
import 'package:picto_flutter_chat/pages/server_choice_page.dart';

import 'auth.dart';

class AuthLayout extends StatelessWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(stream: authService.authStateChanges, builder: (context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.waiting) {
            widget = AppLoadingPage();
          } else if (snapshot.hasData) {
            widget = const ServerChoicePage();
          } else {
            widget = pageIfNotConnected ?? LoginPage();
          }
          return widget;
        });
      },
    );
  }
}
