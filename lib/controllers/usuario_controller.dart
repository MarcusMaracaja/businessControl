import 'package:sqflite/sqflite.dart';

import '../models/usuario.dart';
import '../helpers/database_helper.dart';

class UsuarioController {
  Future<List<Usuario>> listarUsuarios() async {
    final db = await DatabaseHelper().database;
    final maps = await db.query('usuarios');
    return maps.map((m) => Usuario.fromMap(m)).toList();
  }

  Future<int> salvarUsuario(Usuario usuario) async {
    final db = await DatabaseHelper().database;
    return await db.insert('usuarios', usuario.toMap());
  }

  Future<int> atualizarUsuario(Usuario usuario) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> excluirUsuario(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> inserir(Usuario usuario) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> adicionarUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // substitui se houver duplicata
    );
  }
}
