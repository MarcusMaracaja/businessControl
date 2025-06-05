import 'produto.dart';

class ItemVenda {
  final int? id;
  int idVenda;
  final Produto produto;
  final int quantidade;
  final double precoUnitario;

  ItemVenda({
    this.id,
    required this.idVenda,
    required this.produto,
    required this.quantidade,
    required this.precoUnitario,
  });

  double get subtotal => precoUnitario * quantidade;

  // 👇 usado para SQLite
  factory ItemVenda.fromMap(Map<String, dynamic> map) {
    return ItemVenda(
      id: map['id'],
      idVenda: map['idVenda'],
      produto: Produto(id: map['idProduto'], nome: '', preco: map['precoUnitario'], quantidade: 0, codigoBarras: '', idEmpresa: 0),
      quantidade: map['quantidade'],
      precoUnitario: map['precoUnitario'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'idVenda': idVenda,
      'idProduto': produto.id,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // 👇 usado para API, se quiser manter
  factory ItemVenda.fromJson(Map<String, dynamic> json) {
    return ItemVenda(
      id: json['id'],
      idVenda: json['idVenda'],
      produto: Produto.fromJson(json['produto']),
      quantidade: json['quantidade'],
      precoUnitario: json['precoUnitario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idVenda': idVenda,
      'produto': produto.toJson(),
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
    };
  }
}
