class Produto {
  int? id;
  String nome;
  double preco;
  int quantidade;
  String codigoBarras;
  int idEmpresa;
  int? estoque; // Agora pode receber null

  // ✅ agora pode ser alterado



  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.codigoBarras,
    required this.idEmpresa,
    required this.estoque,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nome,
    'preco': preco,
    'quantidade': quantidade,
    'codigoBarras': codigoBarras,
    'idEmpresa': idEmpresa,
  };

  static Produto fromMap(Map<String, dynamic> map) => Produto(
    id: map['id'],
    nome: map['nome'],
    preco: map['preco'],
    quantidade: map['quantidade'],
    codigoBarras: map['codigoBarras'],
    idEmpresa: map['idEmpresa'], 
    estoque: null,
  );
}