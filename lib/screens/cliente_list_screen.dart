import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../controllers/cliente_controller.dart';
import 'cliente_form_screen.dart';
import 'venda_list_screen.dart'; // <--- IMPORTAÇÃO ADICIONADA

class ClienteListScreen extends StatefulWidget {
  final int idEmpresa;

  const ClienteListScreen({super.key, required this.idEmpresa});

  @override
  State<ClienteListScreen> createState() => _ClienteListScreenState();
}

class _ClienteListScreenState extends State<ClienteListScreen> {
  final _ctrl = ClienteController();
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _clientes = await _ctrl.listarPorEmpresa(widget.idEmpresa);
    setState(() {});
  }

  Future<void> _openForm([Cliente? c]) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ClienteFormScreen(cliente: c, idEmpresa: widget.idEmpresa),
      ),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Cliente cliente) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Cliente'),
        content: Text('Deseja excluir ${cliente.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _ctrl.excluirCliente(cliente.id!);
              Navigator.pop(ctx);
              _load();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _abrirVendas(Cliente cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VendaListScreen(idCliente: cliente.id!),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Clientes')),
    body: ListView.builder(
      itemCount: _clientes.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_clientes[i].nome),
        subtitle: Text(_clientes[i].telefone),
        trailing: Wrap(
          spacing: 12,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Ver Vendas',
              onPressed: () => _abrirVendas(_clientes[i]),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Excluir Cliente',
              onPressed: () => _confirmDelete(_clientes[i]),
            ),
          ],
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
