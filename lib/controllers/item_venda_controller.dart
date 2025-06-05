import '../models/item_venda.dart';
import '../helpers/database_helper.dart';

class ItemVendaController {
  Future<List<ItemVenda>> listarItensPorVenda(int idVenda) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'itens_venda',
      where: 'idVenda = ?',
      whereArgs: [idVenda],
    );
    return result.map((e) => ItemVenda.fromMap(e)).toList();
  }

  Future<int> salvarItem(ItemVenda item) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('itens_venda', item.toMap());
  }

  Future<int> atualizarItem(ItemVenda item) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'itens_venda',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> excluirItem(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'itens_venda',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
