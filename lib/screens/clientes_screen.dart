import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../controllers/cliente_controller.dart';
import 'cliente_form_screen.dart';

class ClientesScreen extends StatefulWidget {
  final int idEmpresa;
  const ClientesScreen({super.key, required this.idEmpresa});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    carregarClientes();
  }

  Future<void> carregarClientes() async {
    final lista = await ClienteController().listarPorEmpresa(widget.idEmpresa);
    setState(() => clientes = lista);
  }

  void irParaCadastro() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClienteFormScreen(idEmpresa: widget.idEmpresa),
      ),
    );
    if (resultado == true) carregarClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: irParaCadastro,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final c = clientes[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text(c.telefone),
          );
        },
      ),
    );
  }
}
