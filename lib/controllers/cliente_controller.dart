import '../models/cliente.dart';
import '../helpers/database_helper.dart';

class ClienteController {
  Future<List<Cliente>> listarClientes() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('clientes');
    return result.map((e) => Cliente.fromMap(e)).toList();
  }

  Future<int> salvarCliente(Cliente cliente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('clientes', cliente.toMap());
  }

  Future<int> atualizarCliente(Cliente cliente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'clientes',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<int> excluirCliente(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
