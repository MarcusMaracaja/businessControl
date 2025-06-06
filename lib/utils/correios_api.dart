import 'dart:convert';
import 'package:http/http.dart' as http;

class Endereco {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  Endereco({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
      ibge: json['ibge'] ?? '',
      gia: json['gia'] ?? '',
      ddd: json['ddd'] ?? '',
      siafi: json['siafi'] ?? '',
    );
  }

  @override
  String toString() {
    return '$logradouro, $bairro, $localidade-$uf, CEP: $cep';
  }
}

class CorreiosAPI {
  static Future<String> consultarEndereco(String cep) async {
    // Remove caracteres não numéricos do CEP
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length != 8) {
      return 'CEP inválido. Digite 8 números';
    }

    try {
      final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Tempo limite excedido na consulta');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verifica se o CEP foi encontrado
        if (data.containsKey('erro')) {
          return 'CEP não encontrado';
        }

        // Mantém o formato original de retorno
        return '${data['logradouro']}, ${data['bairro']}, ${data['localidade']}-${data['uf']}';
      } else {
        throw Exception('Falha ao consultar CEP');
      }
    } catch (e) {
      return 'Erro na consulta: $e';
    }
  }
}
