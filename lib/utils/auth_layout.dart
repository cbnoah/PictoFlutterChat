import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/pages/app_loading_page.dart';
import 'package:picto_flutter_chat/pages/login_page.dart';
import 'package:picto_flutter_chat/pages/server_choice_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthLayout extends StatelessWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {

          // loading response
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingPage();
          }

          final session = snapshot.hasData ? snapshot.data!.session : null;

          if (session != null) {
            return ServerChoicePage();
          } else {
            return LoginPage();
          }
        }
    );
  }
}
