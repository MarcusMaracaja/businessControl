import 'package:business_control_app/models/item_venda.dart';

import 'cliente.dart';

class Venda {
  int? id;
  int idEmpresa;
  int idCliente;
  String data; // use string para simplificar
  double valorTotal;
  List<ItemVenda> itens;

  Venda({
    this.id,
    required this.idEmpresa,
    required this.idCliente,
    required this.data,
    required this.valorTotal,
    this.itens = const [],
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'idEmpresa': idEmpresa,
    'idCliente': idCliente,
    'data': data,
    'valorTotal': valorTotal,
  };

  factory Venda.fromMap(Map<String, dynamic> m) => Venda(
    id: m['id'],
    idEmpresa: m['idEmpresa'],
    idCliente: m['idCliente'],
    data: m['data'],
    valorTotal: m['valorTotal'],
  );

}
