import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registrar')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome')),
          TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email')),
          TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final novoUsuario = Usuario(
                nome: nomeController.text,
                email: emailController.text,
                senha: senhaController.text,
              );

              await UsuarioController().adicionarUsuario(novoUsuario);
              Navigator.pop(context); // Volta pra tela de login
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    ),
  );
}
