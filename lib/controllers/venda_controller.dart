import 'package:business_control_app/models/cliente.dart';

import 'package:business_control_app/models/produto.dart';

import '../models/venda.dart';
import '../models/item_venda.dart';
import '../helpers/database_helper.dart';

class VendaController {
  Future<List<Venda>> listarVendas() async {
    final db = await DatabaseHelper().database;
    final maps = await db.query('venda');
    return maps.map((m) => Venda.fromMap(m)).toList();
  }

  Future<int> salvarVenda(Venda venda, List<ItemVenda> itens) async {
    final db = await DatabaseHelper().database;
    final idVenda = await db.insert('venda', venda.toMap());
    for (var item in itens) {
      item.idVenda = idVenda;
      await db.insert('itemVenda', item.toMap());
    }
    return idVenda;
  }

  Future<int> excluirVenda(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('itemVenda', where: 'idVenda = ?', whereArgs: [id]);
    return await db.delete('venda', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Venda>> listarPorEmpresa(int idEmpresa) async {
    final db = await DatabaseHelper().database;

    final vendasData = await db.query(
      'venda',
      where: 'idEmpresa = ?',
      whereArgs: [idEmpresa],
    );

    List<Venda> vendas = [];

    for (var vendaMap in vendasData) {
      final venda = Venda.fromMap(vendaMap);

      // Carrega os itens da venda
      final itensData = await db.query(
        'item_venda',
        where: 'idVenda = ?',
        whereArgs: [venda.id],
      );

      final itens = itensData.map((m) => ItemVenda.fromMap(m)).toList();

      // Atribui os itens e calcula total
      venda.itens = itens;
      venda.valorTotal = itens.fold(0, (s, i) => s + (i.precoUnitario ?? 0) * i.quantidade);

      vendas.add(venda);
    }

    return vendas;
  }

  Future<void> realizarVenda({
    required Cliente cliente,
    required Map<Produto, int> itens,
  }) async {
    final db = await DatabaseHelper().database;

    await db.transaction((txn) async {
      // 1. Inserir venda
      final idVenda = await txn.insert('vendas', {
        'idCliente': cliente.id,
        'data': DateTime.now().toIso8601String(),
      });

      // 2. Inserir itens da venda
      for (final entry in itens.entries) {
        final produto = entry.key;
        final qtd = entry.value;

        await txn.insert('itens_venda', {
          'idVenda': idVenda,
          'idProduto': produto.id,
          'quantidade': qtd,
          'valorUnitario': produto.preco,
        });

        // 3. Atualizar estoque
        final novoEstoque = (produto.quantidade ?? 0) - qtd;
        await txn.update(
          'produtos',
          {'quantidade': novoEstoque},
          where: 'id = ?',
          whereArgs: [produto.id],
        );
      }
    });
  }



}
