import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper  _instance = DatabaseHelper ._internal();
  static DatabaseHelper get instance => _instance;

  factory DatabaseHelper () => _instance;

  DatabaseHelper ._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'business_control.db');

    return await openDatabase(
      path,
      version: 4, // aumente a versão para forçar o upgrade
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Apaga todas as tabelas antigas
        await db.execute('DROP TABLE IF EXISTS usuarios');
        await db.execute('DROP TABLE IF EXISTS empresas');
        await db.execute('DROP TABLE IF EXISTS produto');
        await db.execute('DROP TABLE IF EXISTS cliente');
        await db.execute('DROP TABLE IF EXISTS venda');
        await db.execute('DROP TABLE IF EXISTS itemVenda');

        // Cria tudo de novo
        await _onCreate(db, newVersion);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE empresas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        cnpj TEXT,
        telefone TEXT,
        idUsuario INTEGER,
        FOREIGN KEY (idUsuario) REFERENCES usuario(id)
      )
    ''');
    // Tabela produto
    await db.execute('''
    CREATE TABLE produto (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      preco REAL,
      quantidade INTEGER,
      codigoBarras TEXT,
      idEmpresa INTEGER,
      FOREIGN KEY (idEmpresa) REFERENCES empresa(id)
    );
  ''');

    // Tabela cliente
    await db.execute('''
    CREATE TABLE cliente (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      telefone TEXT,
      cep TEXT,
      endereco TEXT,
      idEmpresa INTEGER,
      FOREIGN KEY (idEmpresa) REFERENCES empresa(id)
    );
  ''');

    // Tabela venda
    await db.execute('''
    CREATE TABLE venda (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idEmpresa INTEGER,
      idCliente INTEGER,
      data TEXT,
      valorTotal REAL,
      FOREIGN KEY (idEmpresa) REFERENCES empresa(id),
      FOREIGN KEY (idCliente) REFERENCES cliente(id)
    );
  ''');

    // Tabela itemVenda
    await db.execute('''
    CREATE TABLE itemVenda (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idVenda INTEGER,
      idProduto INTEGER,
      quantidade INTEGER,
      precoUnitario REAL,
      FOREIGN KEY (idVenda) REFERENCES venda(id),
      FOREIGN KEY (idProduto) REFERENCES produto(id)
    );
  ''');
  }
}
