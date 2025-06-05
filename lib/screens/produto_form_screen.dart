import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../controllers/produto_controller.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;
  const ProdutoFormScreen({super.key, this.produto});

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _preco = TextEditingController();
  final _qtd = TextEditingController();
  final _codBar = TextEditingController();
  final _ctrl = ProdutoController();

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) {
      _nome.text = widget.produto!.nome;
      _preco.text = widget.produto!.preco.toString();
      _qtd.text = widget.produto!.quantidade.toString();
      _codBar.text = widget.produto!.codigoBarras ?? '';
    }
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text(widget.produto == null ? 'Novo Produto' : 'Editar Produto')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome')),
            TextFormField(controller: _preco, decoration: const InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
            TextFormField(controller: _qtd, decoration: const InputDecoration(labelText: 'Quantidade'), keyboardType: TextInputType.number),
            TextFormField(controller: _codBar, decoration: const InputDecoration(labelText: 'Código de Barras')),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                if (!_form.currentState!.validate()) return;
                final p = Produto(
                  id: widget.produto?.id,
                  nome: _nome.text,
                  preco: double.parse(_preco.text),
                  quantidade: int.parse(_qtd.text),
                  codigoBarras: _codBar.text,
                  idEmpresa: /*id atual*/,
                );
                if (widget.produto == null) await _ctrl.inserir(p);
                else await _ctrl.atualizar(p);
                Navigator.pop(ctx, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
