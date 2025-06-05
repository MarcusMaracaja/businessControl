class Produto {
  int? id;
  String nome;
  double preco;
  int quantidade;
  String codigoBarras;
  int idEmpresa;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.codigoBarras,
    required this.idEmpresa,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
      quantidade: map['quantidade'],
      codigoBarras: map['codigoBarras'],
      idEmpresa: map['idEmpresa'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nome': nome,
      'preco': preco,
      'quantidade': quantidade,
      'codigoBarras': codigoBarras,
      'idEmpresa': idEmpresa,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Produto.fromJson(Map<String, dynamic> json) => Produto.fromMap(json);
  Map<String, dynamic> toJson() => toMap();
}
