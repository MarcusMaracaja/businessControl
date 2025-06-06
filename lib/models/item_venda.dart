import 'produto.dart';

class ItemVenda {
  int? id;
  int? idVenda;
  int idProduto;
  int quantidade;
  double precoUnitario;

  ItemVenda({
    this.id,
    required this.idVenda,
    required this.idProduto,
    required this.quantidade,
    required this.precoUnitario,
  });

  double get subtotal => precoUnitario * quantidade;

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'idVenda': idVenda,
    'idProduto': idProduto,
    'quantidade': quantidade,
    'precoUnitario': precoUnitario,
  };

  factory ItemVenda.fromMap(Map<String, dynamic> m) => ItemVenda(
    id: m['id'],
    idVenda: m['idVenda'],
    idProduto: m['idProduto'],
    quantidade: m['quantidade'],
    precoUnitario: m['precoUnitario'],
  );
}
