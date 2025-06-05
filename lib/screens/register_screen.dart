import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registrar')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Nome')),
          const TextField(decoration: InputDecoration(labelText: 'Email')),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Registrar'),
          )
        ],
      ),
    ),
  );
}