import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../models/produto.dart';
import '../controllers/cliente_controller.dart';
import '../controllers/produto_controller.dart';
import '../controllers/venda_controller.dart';

class VendaScreen extends StatefulWidget {
  final int idEmpresa;

  const VendaScreen({super.key, required this.idEmpresa});

  @override
  State<VendaScreen> createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  Cliente? _clienteSelecionado;
  List<Produto> _produtosDisponiveis = [];
  final Map<Produto, int> _carrinho = {};
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    final produtos = await ProdutoController().listarProdutos(widget.idEmpresa);
    setState(() => _produtosDisponiveis = produtos);
  }

  void _atualizarTotal() {
    double novoTotal = 0;
    _carrinho.forEach((produto, qtd) {
      novoTotal += produto.preco * qtd;
    });
    setState(() => _total = novoTotal);
  }

  void _selecionarProduto(Produto produto) {
    showDialog(
      context: context,
      builder: (_) {
        final _qtdController = TextEditingController(text: '1');
        return AlertDialog(
          title: Text('Quantidade - ${produto.nome}'),
          content: TextField(
            controller: _qtdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantidade'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final qtd = int.tryParse(_qtdController.text) ?? 1;
                if (qtd <= 0 || (produto.estoque != null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Estoque insuficiente. Disponível: ${produto.estoque}')),
                  );
                  return;
                }

                setState(() {
                  _carrinho[produto] = (_carrinho[produto] ?? 0) + qtd;
                  if (produto.estoque != null) {
                    produto.estoque = (produto.estoque ?? 0) - qtd;
                  }
                  _atualizarTotal();
                });

                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _selecionarCliente() async {
    final clientes = await ClienteController().listarClientes(widget.idEmpresa);
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: clientes
            .map(
              (c) => ListTile(
            title: Text(c.nome),
            onTap: () {
              setState(() => _clienteSelecionado = c);
              Navigator.pop(context);
            },
          ),
        )
            .toList(),
      ),
    );
  }

  Future<void> _realizarVenda() async {
    if (_clienteSelecionado == null || _carrinho.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um cliente e adicione produtos')),
      );
      return;
    }

    await VendaController().realizarVenda(
      cliente: _clienteSelecionado!,
      itens: _carrinho,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Venda realizada com sucesso!')),
    );

    Navigator.pop(context, true); // Sinaliza que deve recarregar a lista na tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Venda')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _selecionarCliente,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _clienteSelecionado?.nome ?? 'Selecionar Cliente',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de produtos
            Expanded(
              child: ListView.builder(
                itemCount: _produtosDisponiveis.length,
                itemBuilder: (_, index) {
                  final produto = _produtosDisponiveis[index];
                  return ListTile(
                    title: Text(produto.nome),
                    subtitle: Text(
                      'R\$ ${produto.preco.toStringAsFixed(2)} | Estoque: ${produto.estoque}',
                    ),
                    trailing: const Icon(Icons.add),
                    onTap: () => _selecionarProduto(produto),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Carrinho
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _carrinho.entries.map((e) {
                return Text(
                  '${e.key.nome} x${e.value} = R\$ ${(e.key.preco * e.value).toStringAsFixed(2)}',
                );
              }).toList(),
            ),

            const SizedBox(height: 10),
            Text(
              'Total: R\$ ${_total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _realizarVenda,
              child: const Text('Vender'),
            ),
          ],
        ),
      ),
    );
  }
}