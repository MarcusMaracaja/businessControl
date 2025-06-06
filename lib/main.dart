import 'package:business_control_app/screens/home_screen.dart';
import 'package:business_control_app/screens/login_screen.dart';
import 'package:business_control_app/screens/register_screen.dart';
import 'package:business_control_app/utils/correios_api.dart';
import 'package:flutter/material.dart';
import 'screens/usuario_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Control App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

