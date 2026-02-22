import 'package:picto_flutter_chat/utils/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:picto_flutter_chat/theme/light_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fukfxrdnjnidqpgqtbtp.supabase.co',
    anonKey: 'sb_publishable_dNlnFts7H19CqPOocML9Gw_8TUF1rwC',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: AuthLayout(),
    );
  }
}
