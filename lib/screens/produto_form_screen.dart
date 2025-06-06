import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../controllers/produto_controller.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;
  final int idEmpresa;

  const ProdutoFormScreen({
    super.key,
    this.produto,
    required this.idEmpresa,
  });

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}


class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _codigoController = TextEditingController();

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      final produto = Produto(
        id: widget.produto?.id,
        nome: _nomeController.text,
        preco: double.tryParse(_precoController.text) ?? 0,
        quantidade: int.tryParse(_quantidadeController.text) ?? 0,
        codigoBarras: _codigoController.text,
        idEmpresa: widget.idEmpresa, estoque: null,
      );
      await ProdutoController().salvarProduto(produto);
      Navigator.pop(context, true); // Volta para lista
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDadosProduto();
  }

  void _carregarDadosProduto() {
    if (widget.produto != null) {
      try {
        _nomeController.text = widget.produto?.nome ?? '';
        _precoController.text = widget.produto?.preco?.toStringAsFixed(2) ?? '0.00';
        _quantidadeController.text = widget.produto?.quantidade?.toString() ?? '0';
        _codigoController.text = widget.produto?.codigoBarras ?? '';
      } catch (e) {
        debugPrint('Erro ao carregar dados do produto: $e');
        // Você pode adicionar um SnackBar ou outro feedback visual aqui
      }
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _quantidadeController.dispose();
    _codigoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _codigoController,
                decoration: const InputDecoration(labelText: 'Código de Barras'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}