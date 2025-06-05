import 'package:flutter/material.dart';
import '../models/venda.dart';
import '../controllers/venda_controller.dart';
import 'venda_form_screen.dart';

class VendaListScreen extends StatefulWidget {
  const VendaListScreen({super.key});
  @override
  State<VendaListScreen> createState() => _VendaListScreenState();
}

class _VendaListScreenState extends State<VendaListScreen> {
  final _ctrl = VendaController();
  List<Venda> _vendas = [];

  Future<void> _load() async {
    _vendas = await _ctrl.listarPorEmpresa(/*id da empresa*/);
    setState(() {});
  }

  Future<void> _openForm() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const VendaFormScreen()),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Venda v) { /* similar... */ }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Vendas')),
    body: ListView.builder(
      itemCount: _vendas.length,
      itemBuilder: (_, i) {
        final v = _vendas[i];
        return ListTile(
          title: Text(v.cliente.nome),
          subtitle: Text('R\$ ${v.total.toStringAsFixed(2)} em ${v.itens.length} itens'),
          onLongPress: () => _confirmDelete(v),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _openForm,
      child: const Icon(Icons.add_shopping_cart),
    ),
  );
}
