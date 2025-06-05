import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../controllers/produto_controller.dart';
import 'produto_form_screen.dart';

class ProdutoListScreen extends StatefulWidget {
  const ProdutoListScreen({super.key});
  @override
  State<ProdutoListScreen> createState() => _ProdutoListScreenState();
}

class _ProdutoListScreenState extends State<ProdutoListScreen> {
  final _ctrl = ProdutoController();
  List<Produto> _produtos = [];

  Future<void> _load() async {
    _produtos = await _ctrl.listarPorEmpresa(/*id da empresa selecionada*/);
    setState(() {});
  }

  Future<void> _openForm([Produto? p]) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ProdutoFormScreen(produto: p)),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Produto p) {
    showDialog(...); // similar ao anterior
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Produtos')),
    body: ListView.builder(
      itemCount: _produtos.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_produtos[i].nome),
        subtitle: Text('Qtd: ${_produtos[i].quantidade} | R\$ ${_produtos[i].preco}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _confirmDelete(_produtos[i]),
        ),
        onTap: () => _openForm(_produtos[i]),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _openForm(),
      child: const Icon(Icons.add),
    ),
  );
}
