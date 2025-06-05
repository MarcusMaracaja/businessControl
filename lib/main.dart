import 'package:flutter/material.dart';
import 'screens/usuario_list_screen.dart';

void main() {
  runApp(const ControlBusinessApp());
}

class ControlBusinessApp extends StatelessWidget {
  const ControlBusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Business App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const UsuarioListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
