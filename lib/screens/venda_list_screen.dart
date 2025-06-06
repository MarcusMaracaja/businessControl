import 'package:flutter/material.dart';
import '../models/venda.dart';
import '../controllers/venda_controller.dart';
import 'venda_form_screen.dart';

class VendaListScreen extends StatefulWidget {
  const VendaListScreen({super.key, required int idCliente});

  @override
  State<VendaListScreen> createState() => _VendaListScreenState();
}

class _VendaListScreenState extends State<VendaListScreen> {
  final _ctrl = VendaController();
  List<Venda> _vendas = [];

  final int _idEmpresa = 1; // Exemplo fixo

  Future<void> _load() async {
    _vendas = await _ctrl.listarPorEmpresa(_idEmpresa);
    setState(() {});
  }

  Future<void> _openForm([Venda? v]) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => VendaFormScreen(venda: v)),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Venda v) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Excluir esta venda?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await _ctrl.excluirVenda(v.id!);
              Navigator.pop(context);
              _load();
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Vendas')),
    body: ListView.builder(
      itemCount: _vendas.length,
      itemBuilder: (_, i) => ListTile(
        title: Text('Venda ${_vendas[i].id}'),
        subtitle: Text('Total: R\$ ${_vendas[i].valorTotal.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _confirmDelete(_vendas[i]),
        ),
        onTap: () => _openForm(_vendas[i]),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _openForm(),
      child: const Icon(Icons.add),
    ),
  );
}
