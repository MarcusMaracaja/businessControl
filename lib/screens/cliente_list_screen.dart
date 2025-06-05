import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../controllers/cliente_controller.dart';
import 'cliente_form_screen.dart';

class ClienteListScreen extends StatefulWidget {
  const ClienteListScreen({super.key});
  @override
  State<ClienteListScreen> createState() => _ClienteListScreenState();
}

class _ClienteListScreenState extends State<ClienteListScreen> {
  final _ctrl = ClienteController();
  List<Cliente> _clientes = [];

  Future<void> _load() async {
    _clientes = await _ctrl.listarPorEmpresa(/*id da empresa*/);
    setState(() {});
  }

  Future<void> _openForm([Cliente? c]) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ClienteFormScreen(cliente: c)),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Cliente c) { /* ...similar ao anterior... */ }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Clientes')),
    body: ListView.builder(
      itemCount: _clientes.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_clientes[i].nome),
        subtitle: Text(_clientes[i].telefone),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _confirmDelete(_clientes[i]),
        ),
        onTap: () => _openForm(_clientes[i]),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _openForm(),
      child: const Icon(Icons.add),
    ),
  );
}
