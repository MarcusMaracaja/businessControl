import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../controllers/produto_controller.dart';
import 'produto_form_screen.dart';

class ProdutosScreen extends StatefulWidget {
  final int idEmpresa;
  const ProdutosScreen({super.key, required this.idEmpresa});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    final lista = await ProdutoController().listarPorEmpresa(widget.idEmpresa);
    setState(() => produtos = lista);
  }

  void irParaCadastro() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutoFormScreen(idEmpresa: widget.idEmpresa),
      ),
    );
    if (resultado == true) carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: irParaCadastro,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final p = produtos[index];
          return ListTile(
            title: Text(p.nome),
            subtitle: Text('Estoque: ${p.quantidade}'),
          );
        },
      ),
    );
  }
}
