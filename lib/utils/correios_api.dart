import 'dart:convert';
import 'package:http/http.dart' as http;

class CorreiosAPI {
  static Future<String> consultarEndereco(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      if (data['erro'] == true) {
        return 'CEP não encontrado';
      }
      return '${data['logradouro']}, ${data['bairro']}, ${data['localidade']}-${data['uf']}';
    } else {
      throw Exception('Falha ao consultar CEP');
    }
  }
}
