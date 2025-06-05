import '../models/venda.dart';
import '../models/item_venda.dart';
import '../helpers/database_helper.dart';

class VendaController {
  Future<List<Venda>> listarVendas() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('vendas');
    return result.map((e) => Venda.fromMap(e)).toList();
  }

  Future<int> salvarVenda(Venda venda) async {
    final db = await DatabaseHelper.instance.database;
    final idVenda = await db.insert('vendas', venda.toMap());

    for (var item in venda.itens) {
      item.idVenda = idVenda;
      await db.insert('itens_venda', item.toMap());
    }

    return idVenda;
  }

  Future<int> excluirVenda(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('itens_venda', where: 'idVenda = ?', whereArgs: [id]);
    return await db.delete('vendas', where: 'id = ?', whereArgs: [id]);
  }
}
