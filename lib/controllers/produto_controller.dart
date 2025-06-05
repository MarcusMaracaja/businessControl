import '../models/produto.dart';
import '../helpers/database_helper.dart';

class ProdutoController {
  Future<List<Produto>> listarProdutos() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('produtos');
    return result.map((e) => Produto.fromMap(e)).toList();
  }

  Future<int> salvarProduto(Produto produto) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('produtos', produto.toMap());
  }

  Future<int> atualizarProduto(Produto produto) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'produtos',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<int> excluirProduto(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
