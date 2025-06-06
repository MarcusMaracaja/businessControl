import 'package:business_control_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'empresa_list_screen.dart';
import 'produto_list_screen.dart';
import 'usuario_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Início')),

    // 🔥 Aqui está o menu lateral sendo incluído
    drawer: const AppDrawer(),

    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          title: const Text('Empresas'),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const EmpresaListScreen())),
        ),
        ListTile(
          title: const Text('Produtos'),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ProdutoListScreen())),
        ),
        ListTile(
          title: const Text('Usuários'),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const UsuarioListScreen())),
        ),
      ],
    ),
  );
}
