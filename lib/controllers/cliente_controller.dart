import 'package:sqflite/sqflite.dart';
import '../models/cliente.dart';
import '../helpers/database_helper.dart';

class ClienteController {
  Future<int> salvarCliente(Cliente cliente) async {
    final db = await DatabaseHelper().database;
    return await db.insert('cliente', cliente.toMap());
  }

  Future<List<Cliente>> listarPorEmpresa(int idEmpresa) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query('cliente', where: 'idEmpresa = ?', whereArgs: [idEmpresa]);
    return maps.map((m) => Cliente.fromMap(m)).toList();
  }

  Future<int> atualizarCliente(Cliente cliente) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'cliente',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<int> excluirCliente(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'cliente',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Cliente>> listarClientes(int idEmpresa) async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'clientes',
      where: 'idEmpresa = ?',
      whereArgs: [idEmpresa],
    );
    return result.map((e) => Cliente.fromMap(e)).toList();
  }


}
