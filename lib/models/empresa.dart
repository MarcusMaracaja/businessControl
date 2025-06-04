class Empresa {
  int? id;
  String nome;
  String cnpj;
  String telefone;
  int idUsuario; // Relacionamento com o usuário

  Empresa({
    this.id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'idUsuario': idUsuario,
    };
  }

  factory Empresa.fromMap(Map<String, dynamic> map) {
    return Empresa(
      id: map['id'],
      nome: map['nome'],
      cnpj: map['cnpj'],
      telefone: map['telefone'],
      idUsuario: map['idUsuario'],
    );
  }
}
