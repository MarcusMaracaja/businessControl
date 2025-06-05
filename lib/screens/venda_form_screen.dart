import 'package:flutter/material.dart';
import '../models/venda.dart';
import '../models/item_venda.dart';
import '../models/produto.dart';
import '../models/cliente.dart';
import '../controllers/venda_controller.dart';
import '../controllers/item_venda_controller.dart';
import '../controllers/produto_controller.dart';
import '../controllers/cliente_controller.dart';

class VendaFormScreen extends StatefulWidget {
  const VendaFormScreen({super.key});
  @override
  State<VendaFormScreen> createState() => _VendaFormScreenState();
}

class _VendaFormScreenState extends State<VendaFormScreen> {
  final _vCtrl = VendaController();
  final _iCtrl = ItemVendaController();
  final _pCtrl = ProdutoController();
  final _cCtrl = ClienteController();

  List<Produto> _produtos = [];
  List<Cliente> _clientes = [];
  Cliente? _clienteSelecionado;
  final List<ItemVenda> _itens = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _produtos = await _pCtrl.listarPorEmpresa(/* id empresa */);
    _clientes = await _cCtrl.listarPorEmpresa(/* id empresa */);
    setState(() {});
  }

  void _addItem() async {
    final p = await showDialog<Produto>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Selecionar produto'),
        children: _produtos.map((p) => SimpleDialogOption(
          onPressed: () => Navigator.pop(context, p),
          child: Text('${p.nome} - R\$ ${p.preco}'),
        )).toList(),
      ),
    );
    if (p != null) {
      final qtdC = TextEditingController();
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Quantidade para ${p.nome}?'),
          content: TextField(controller: qtdC, keyboardType: TextInputType.number),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            TextButton(
              onPressed: () => Navigator.pop(context, qtdC.text),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      if (int.tryParse(qtdC.text) != null) {
        _itens.add(ItemVenda(produto: p, quantidade: int.parse(qtdC.text)));
        setState(() {});
      }
    }
  }

  double get _total => _itens.fold(0, (s, i) => s + i.subtotal);

  Future<void> _save() async {
    if (_clienteSelecionado == null || _itens.isEmpty) return;
    final v = Venda(
      id: null,
      cliente: _clienteSelecionado!,
      itens: _itens,
      dataHora: DateTime.now(),
    );
    final vendaId = await _vCtrl.inserir(v);
    for (var item in _itens) {
      await _iCtrl.inserir(item..vendaId = vendaId);
      await _pCtrl.reporEstoque(item.produto.id!, -item.quantidade);
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Nova Venda')),
    body: _clientes.isEmpty
        ? const Center(child: Text('Cadastre um cliente primeiro'))
        : Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButton<Cliente>(
            isExpanded: true,
            hint: const Text('Selecione o cliente'),
            value: _clienteSelecionado,
            items: _clientes.map((c) => DropdownMenuItem(
              value: c,
              child: Text(c.nome),
            )).toList(),
            onChanged: (v) => setState(() => _clienteSelecionado = v),
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _addItem, child: const Text('Adicionar produto')),
          const SizedBox(height: 8),
          Text('Total: R\$ ${_total.toStringAsFixed(2)}'),
          Expanded(child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (_, i) => ListTile(
              title: Text('${_itens[i].produto.nome} x${_itens[i].quantidade} = R\$ ${_itens[i].subtotal.toStringAsFixed(2)}'),
            ),
          )),
          ElevatedButton(onPressed: _save, child: const Text('Finalizar Venda')),
        ],
      ),
    ),
  );
}
