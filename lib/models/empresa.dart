class Empresa {
  int? id;
  String nome;
  String cnpj;
  String telefone;
  int idUsuario;

  Empresa({
    this.id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'nome': nome,
    'cnpj': cnpj,
    'telefone': telefone,
    'idUsuario': idUsuario,
  };

  factory Empresa.fromMap(Map<String, dynamic> m) => Empresa(
    id: m['id'],
    nome: m['nome'],
    cnpj: m['cnpj'],
    telefone: m['telefone'],
    idUsuario: m['idUsuario'],
  );
}
