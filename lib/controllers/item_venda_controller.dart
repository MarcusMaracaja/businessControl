import '../models/item_venda.dart';
import '../helpers/database_helper.dart';

class ItemVendaController {
  Future<List<ItemVenda>> listarItensPorVenda(int idVenda) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query(
      'itens_venda',
      where: 'idVenda = ?',
      whereArgs: [idVenda],
    );

    return maps.map((map) => ItemVenda.fromMap(map)).toList();
  }

  Future<int> salvarItemVenda(ItemVenda item) async {
    final db = await DatabaseHelper().database;
    return await db.insert('itens_venda', item.toMap());
  }

  Future<int> atualizarItemVenda(ItemVenda item) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'itens_venda',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> excluirItemVenda(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'itens_venda',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> excluirItensPorVenda(int idVenda) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'itens_venda',
      where: 'idVenda = ?',
      whereArgs: [idVenda],
    );
  }
}
