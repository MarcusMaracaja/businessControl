import 'package:business_control_app/models/item_venda.dart';
import 'package:sqflite/sqflite.dart';
import '../helpers/database_helper.dart';
import '../models/venda.dart';
import 'produto_dao.dart';

class VendaDAO {
  Future<void> registrarVenda({
    required Venda venda,
    required List<ItemVenda> itens,
  }) async {
    final db = await DatabaseHelper().database;

    await db.transaction((txn) async {
      // 1. Inserir venda
      final vendaId = await txn.insert('venda', venda.toMap());

      for (final item in itens) {
        // 2. Inserir itens
        await txn.insert('venda_item', {
          ...item.toMap(),
          'id_venda': vendaId,
        });

        // 3. Atualizar estoque do produto
        final estoqueAtual = Sqflite.firstIntValue(await txn.rawQuery(
          'SELECT estoque FROM produto WHERE id = ?',
          [item.idProduto],
        )) ?? 0;

        final novoEstoque = estoqueAtual - item.quantidade;

        await txn.update(
          'produto',
          {'estoque': novoEstoque},
          where: 'id = ?',
          whereArgs: [item.idProduto],
        );
      }
    });
  }
}
