import 'cliente.dart';
import 'item_venda.dart';

class Venda {
  final int? id;
  final int idEmpresa;
  final Cliente cliente;
  final List<ItemVenda> itens;
  final DateTime dataHora;

  Venda({
    this.id,
    required this.idEmpresa,
    required this.cliente,
    required this.itens,
    required this.dataHora,
  });

  double get total => itens.fold(0, (sum, item) => sum + item.subtotal);

  // 👇 Usado com SQLite
  factory Venda.fromMap(Map<String, dynamic> map, Cliente cliente, List<ItemVenda> itens) {
    return Venda(
      id: map['id'],
      idEmpresa: map['idEmpresa'],
      cliente: cliente,
      itens: itens,
      dataHora: DateTime.parse(map['data']),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'idEmpresa': idEmpresa,
      'idCliente': cliente.id,
      'data': dataHora.toIso8601String(),
      'valorTotal': total,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // 👇 Usado com API
  factory Venda.fromJson(Map<String, dynamic> json) {
    return Venda(
      id: json['id'],
      idEmpresa: json['idEmpresa'],
      cliente: Cliente.fromMap(json['cliente']),
      itens: (json['itens'] as List)
          .map((item) => ItemVenda.fromJson(item))
          .toList(),
      dataHora: DateTime.parse(json['dataHora']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idEmpresa': idEmpresa,
      'cliente': cliente.toMap(),
      'itens': itens.map((item) => item.toJson()).toList(),
      'dataHora': dataHora.toIso8601String(),
      'total': total,
    };
  }
}
