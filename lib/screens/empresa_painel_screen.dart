// Tela principal após login
import 'package:flutter/material.dart';
import '../models/empresa.dart';
import 'clientes_screen.dart';
import 'produtos_screen.dart';
import 'venda_screen.dart';

class EmpresaPainelScreen extends StatelessWidget {
  final Empresa empresa;

  const EmpresaPainelScreen({super.key, required this.empresa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Empresa: ${empresa.nome}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: const Text('Produtos'),
            leading: const Icon(Icons.inventory),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProdutosScreen(idEmpresa: empresa.id!),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Clientes'),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientesScreen(idEmpresa: empresa.id!),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Vender'),
            leading: const Icon(Icons.point_of_sale),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VendaScreen(idEmpresa: empresa.id!),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
