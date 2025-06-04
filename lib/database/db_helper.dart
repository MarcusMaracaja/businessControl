import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'business_control.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE empresa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        cnpj TEXT,
        telefone TEXT,
        idUsuario INTEGER,
        FOREIGN KEY (idUsuario) REFERENCES usuario(id)
      )
    ''');
  }
}
