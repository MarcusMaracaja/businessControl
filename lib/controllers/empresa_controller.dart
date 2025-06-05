import '../models/empresa.dart';
import '../helpers/database_helper.dart';

class EmpresaController {
  Future<List<Empresa>> listarEmpresas() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('empresas');
    return result.map((e) => Empresa.fromMap(e)).toList();
  }

  Future<int> salvarEmpresa(Empresa empresa) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('empresas', empresa.toMap());
  }

  Future<int> atualizarEmpresa(Empresa empresa) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'empresas',
      empresa.toMap(),
      where: 'id = ?',
      whereArgs: [empresa.id],
    );
  }

  Future<int> excluirEmpresa(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'empresas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
