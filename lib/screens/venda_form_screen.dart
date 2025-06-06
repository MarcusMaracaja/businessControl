import 'package:flutter/material.dart';
import '../models/venda.dart';
import '../models/item_venda.dart';
import '../models/produto.dart';
import '../controllers/venda_controller.dart';
import '../controllers/produto_controller.dart';

class VendaFormScreen extends StatefulWidget {
  final Venda? venda;
  const VendaFormScreen({super.key, this.venda});

  @override
  State<VendaFormScreen> createState() => _VendaFormScreenState();
}

class _VendaFormScreenState extends State<VendaFormScreen> {
  final _ctrlVenda = VendaController();
  final _ctrlProduto = ProdutoController();

  List<Produto> _produtos = [];
  final List<ItemVenda> _itens = [];

  final int _idEmpresa = 1;

  @override
  void initState() {
    super.initState();
    _loadProdutos();
    if (widget.venda != null) {
      _itens.addAll(widget.venda!.itens);
    }
  }

  Future<void> _loadProdutos() async {
    _produtos = await _ctrlProduto.listarPorEmpresa(_idEmpresa);
    setState(() {});
  }

  void _addItem(Produto p) {
    final existente = _itens.where((i) => i.idProduto == p.id).isNotEmpty;
    if (existente) return;

    setState(() {
      _itens.add(ItemVenda(
        idVenda: null,
        idProduto: p.id!,
        quantidade: 1,
        precoUnitario: p.preco,
      ));
    });
  }

  double _calcularTotal() {
    return _itens.fold(0, (s, i) => s + (i.precoUnitario! * i.quantidade));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nova Venda')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Produtos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (_, i) {
                final p = _produtos[i];
                return ListTile(
                  title: Text(p.nome),
                  subtitle: Text('R\$ ${p.preco.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _addItem(p),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const Text('Itens da Venda:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            children: _itens
                .map((i) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produto #${i.idProduto} (x${i.quantidade})'),
                Text('R\$ ${(i.precoUnitario! * i.quantidade).toStringAsFixed(2)}'),
              ],
            ))
                .toList(),
          ),
          const SizedBox(height: 10),
          Text('Total: R\$ ${_calcularTotal().toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final venda = Venda(
                id: widget.venda?.id,
                idEmpresa: _idEmpresa,
                idCliente: 1, // Você pode trocar isso depois
                data: DateTime.now().toIso8601String(),
                valorTotal: _calcularTotal(),
                itens: _itens,
              );
              await _ctrlVenda.salvarVenda(venda, _itens);
              Navigator.pop(context, true);
            },
            child: const Text('Salvar Venda'),
          ),
        ],
      ),
    ),
  );
}
