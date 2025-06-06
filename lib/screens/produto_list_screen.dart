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

  // Substitua com método correto ao integrar autenticação
  final int _idEmpresa = 1;

  Future<void> _load() async {
    _produtos = await _ctrl.listarPorEmpresa(_idEmpresa);
    setState(() {});
  }

  Future<void> _openForm([Produto? p]) async {
  try {
    if (!mounted) return; // Verifica se o widget ainda está montado
    
    final result = await Navigator.push<bool>(
      context,
        MaterialPageRoute(
          builder: (_) => ProdutoFormScreen(produto: p, idEmpresa: _idEmpresa),
        ),
      );
    
    if (mounted) { // Verifica novamente após a operação assíncrona
      if (result ?? false) { // Trata o caso de result ser nulo
        await _load();
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao abrir formulário: $e')),
      );
    }
  }
}

  void _confirmDelete(Produto produto) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Produto'),
        content: Text('Deseja excluir ${produto.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _ctrl.excluirProduto(produto.id!);
              Navigator.pop(ctx);
              _load();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
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
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Produtos')),
    body: ListView.builder(
      itemCount: _produtos.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_produtos[i].nome),
        subtitle: Text('R\$ ${_produtos[i].preco.toStringAsFixed(2)}'),
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