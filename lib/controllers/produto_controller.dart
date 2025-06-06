import 'package:sqflite/sqflite.dart';
import '../models/produto.dart';
import '../helpers/database_helper.dart';

class ProdutoController {
  Future<int> salvarProduto(Produto produto) async {
    final db = await DatabaseHelper().database;
    return await db.insert('produto', produto.toMap());
  }

  Future<List<Produto>> listarPorEmpresa(int idEmpresa) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query('produto', where: 'idEmpresa = ?', whereArgs: [idEmpresa]);
    return maps.map((m) => Produto.fromMap(m)).toList();
  }

  Future<int> excluirProduto(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'produto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Produto>> listarProdutos(int idEmpresa) async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'produtos',
      where: 'idEmpresa = ?',
      whereArgs: [idEmpresa],
    );
    return result.map((e) => Produto.fromMap(e)).toList();
  }

}
