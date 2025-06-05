import 'package:sqflite/sqflite.dart';
import '../helpers//database_helper.dart';
import '../models/usuario.dart';

class UsuarioController {
  // Aponta para o banco inicializado em database_helper.dart
  final Future<Database> _db = DatabaseHelper().database;

  // Método para inserir um usuário no banco
  Future<int> inserir(Usuario u) async {
    final banco = await _db;
    return banco.insert('usuario', u.toMap());
  }

  // Método para autenticar (não usado ainda, mas já pode existir)
  Future<Usuario?> autenticar(String email, String senha) async {
    final banco = await _db;
    final maps = await banco.query(
      'usuario',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (maps.isNotEmpty) return Usuario.fromMap(maps.first);
    return null;
  }

  // Método para listar todos os usuários
  Future<List<Usuario>> listar() async {
    final banco = await _db;
    final maps = await banco.query('usuario');
    return maps.map((m) => Usuario.fromMap(m)).toList();
  }

  // Método para excluir um usuário pelo id
  Future<int> excluir(int id) async {
    final banco = await _db;
    return banco.delete('usuario', where: 'id = ?', whereArgs: [id]);
  }
}
