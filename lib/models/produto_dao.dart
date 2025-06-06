import 'package:sqflite/sqflite.dart';
import '../helpers/database_helper.dart';
import '../models/produto.dart';


class ProdutoDAO {
  Future<List<Produto>> listarPorEmpresa(int idEmpresa) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query(
      'produto',
      where: 'id_empresa = ?',
      whereArgs: [idEmpresa],
    );
    return maps.map((e) => Produto.fromMap(e)).toList();
  }

  Future<void> atualizarEstoque(int idProduto, int novaQtd) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'produto',
      {'estoque': novaQtd},
      where: 'id = ?',
      whereArgs: [idProduto],
    );
  }
}
