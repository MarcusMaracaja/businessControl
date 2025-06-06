import '../models/empresa.dart';
import '../helpers/database_helper.dart';

class EmpresaController {
  Future<List<Empresa>> listarEmpresas() async {
    final db = await DatabaseHelper().database;
    final maps = await db.query('empresas');
    return maps.map((m) => Empresa.fromMap(m)).toList();
  }

  Future<int> salvarEmpresa(Empresa empresa) async {
    final db = await DatabaseHelper().database;
    return await db.insert('empresas', empresa.toMap());
  }

  Future<int> atualizarEmpresa(Empresa empresa) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'empresas',
      empresa.toMap(),
      where: 'id = ?',
      whereArgs: [empresa.id],
    );
  }

  Future<int> excluirEmpresa(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete('empresas', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Empresa>> listarPorUsuario(int idUsuario) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query(
      'empresas',
      where: 'idUsuario = ?',
      whereArgs: [idUsuario],
    );

    return maps.map((map) => Empresa.fromMap(map)).toList();
  }

}
