class Cliente {
  int? id;
  String nome;
  String telefone;
  String cep;
  String endereco;
  int idEmpresa;

  Cliente({
    this.id,
    required this.nome,
    required this.telefone,
    required this.cep,
    required this.endereco,
    required this.idEmpresa,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nome,
    'telefone': telefone,
    'cep': cep,
    'endereco': endereco,
    'idEmpresa': idEmpresa,
  };

  static Cliente fromMap(Map<String, dynamic> map) => Cliente(
    id: map['id'],
    nome: map['nome'],
    telefone: map['telefone'],
    cep: map['cep'],
    endereco: map['endereco'],
    idEmpresa: map['idEmpresa'],
  );
}
