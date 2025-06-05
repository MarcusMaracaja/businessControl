class Cliente {
  final int id;
  final String nome;
  final String documento; // Pode ser CPF ou CNPJ
  final String telefone;
  final String email;

  Cliente({
    required this.id,
    required this.nome,
    required this.documento,
    required this.telefone,
    required this.email,
  });

  factory Cliente.fromMap(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      documento: json['documento'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'documento': documento,
      'telefone': telefone,
      'email': email,
    };
  }
}
